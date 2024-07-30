class UsersController < ApplicationController
  def index
    @users = User.all
    
    # テンプレート用
    # 新規投稿用
    @book_new = Book.new
    # ログインユーザの情報取得（idはcurrent_user.id）
    @user = User.find(current_user.id)
  end
  
  def show
    # 開いているページのid＝表示するユーザidのレコード.books
    @books = User.find(params[:id]).books
    
    # テンプレート用
    # 新規投稿用
    @book_new = Book.new
    # 開いているページのid＝表示するユーザid
    @user = User.find(params[:id])
    
  end

  def edit
  end
end
