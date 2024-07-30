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
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to users_path(current_user.id)
  end
  
  
  
  private
  
  
  def user_params
    # ユーザデータのストロングパラメータ
    # Userモデルに関係したname,introduction,profile_imageカラムのみに限
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
