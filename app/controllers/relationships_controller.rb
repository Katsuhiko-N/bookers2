class RelationshipsController < ApplicationController
  
  def create
    r_ship = Relationship.new
    r_ship.follower_id = current_user.id
    r_ship.followed_id = params[:user_id]
    
    if r_ship.save
      redirect_to book_path(params[:book_id])
      flash[:notice] = "フォローしました"
    else
      redirect_to book_path(params[:book_id])
      flash[:notice] = "フォロー失敗しました"
    end
  end
  
  def index
    @r_ships = Relationship.where(follower_id: current_user.id)
  end
  
  
  def destroy
    r_ship = Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id])
    if r_ship.destroy
      redirect_to book_path(params[:book_id])
      flash[:notice] = "フォロー解除しました"
    else
      redirect_to book_path(params[:book_id])
      flash[:notice] = "フォロー解除失敗しました"
    end
  end
  
end
