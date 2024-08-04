class UsersController < ApplicationController
  # アクション前に実行するメソッド
  before_action :is_matching_login_user, only: [:edit, :update]
  
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
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to users_path(params[:id])
    else
      render :edit
    end
  end
  
  
  
  private
  
  
  def user_params
    # ユーザデータのストロングパラメータ
    # Userモデルに関係したname,introduction,profile_imageカラムのみに限
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    log_in_user = User.find(params[:id])
    unless log_in_user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
end
