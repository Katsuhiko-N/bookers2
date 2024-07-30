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
  end

# 本詳細表示
# 表示中のid=レコード（params）の引数
  def show
    # テンプレート用
    @book_new = Book.new
    @book = Book.find(params[:id])
  end

  def edit
  end
  
  
  private
  
  def book_params
    # 投稿データのストロングパラメータ
    # Bookモデルに関係したtitle,bodyカラムのみに限定
    params.require(:book).permit(:title, :body)
  end
  
  
end
