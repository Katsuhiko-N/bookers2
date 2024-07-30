class BooksController < ApplicationController
  # 投稿画面用
  def new
    @book = Book.new
  end
  
  # 投稿機能
  def create
    @book = Book.new(book_params)
    # 投稿者id=ログインユーザid
    @book.user_id = current_user.id
    @book.save
    # @bookのid=パスの引数
    redirect_to book_path(@book.id)
  end
  
# 本一覧取得
  def index
    @books = Book.all
    
    # 以下テンプレート用
    # 新規投稿用
    @book_new = Book.new
    # ログインユーザの情報取得（idはcurrent_user.id）
    @user = User.find(current_user.id)
    
  end

# 本詳細表示
# 表示中のid=レコード（params）の引数
  def show
    @book = Book.find(params[:id])
    
    # テンプレート用
    # 新規投稿用
    @book_new = Book.new
    # 一つの本のレコードに対しuserは１人の関係だから？ .user
    @user = @book.user
    
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(book.id)
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  
  private
  
  def book_params
    # 投稿データのストロングパラメータ
    # Bookモデルに関係したtitle,bodyカラムのみに限定
    params.require(:book).permit(:title, :body)
  end
  
end