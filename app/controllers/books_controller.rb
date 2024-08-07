class BooksController < ApplicationController
  # アクション前に実行するメソッド
    before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  # 投稿画面用（不要になったためコメントアウト）
  # def new
  #   @book_new = Book.new
  # end
  
  # 投稿機能
  def create
    @book_new = Book.new(book_params)
    # 投稿者id=ログインユーザid
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      # @bookのid=パスの引数
      redirect_to book_path(@book_new.id)
    else
      # render :indexで必要なインスタンス変数
      @books = Book.page(params[:page])
      @user = User.find(current_user.id)
      render :index
    end
  end
  
# 本一覧取得
  def index
    @books = Book.page(params[:page])
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
    @book.user_id = current_user.id
    
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.user_id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  
  private
  
  def book_params
    # 投稿データのストロングパラメータ
    # Bookモデルに関係したtitle,body,user_idカラムのみに限定
    params.require(:book).permit(:title, :body, :user_id)
  end
  
  
  def is_matching_login_user
    log_in_user_id = Book.find(params[:id]).user_id
    unless log_in_user_id == current_user.id
      redirect_to books_path
    end
  end
  
  
end