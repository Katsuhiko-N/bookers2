class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    r_ship = Relationship.new
    r_ship.followed_id = params[:user_id]
    r_ship.follower_id = current_user.id
    if r_ship.save
      case params[:page_id]
      when "0"
        redirect_to users_path
        flash[:notice] = "フォローしました"
      else
        redirect_to user_path(params[:user_id])
        flash[:notice] = "フォローしました"
      end
        
    else
      case params[:page_id]
      when "0"
        redirect_to users_path
        flash[:notice] = "フォロー失敗しました"
      else
        redirect_to user_path(params[:user_id])
        flash[:notice] = "フォロー失敗しました"
      end
    end
  end
  
  def follow_index
    @r_ships = Relationship.where(follower_id: current_user.id).page(params[:page])
  end
  
  def followed_index
    @r_ships = Relationship.where(followed_id: current_user.id).page(params[:page])
  end
  
  
  def destroy
    r_ship = Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id])
    if r_ship.destroy
      case params[:page_id]
      when "0"
        redirect_to users_path
        flash[:notice] = "フォロー解除しました"
      else
        redirect_to user_path(params[:user_id])
        flash[:notice] = "フォロー解除しました"
      end
        
    else
      case params[:page_id]
      when "0"
        redirect_to users_path
        flash[:notice] = "フォロー解除失敗しました"
      else
        redirect_to user_path(params[:user_id])
        flash[:notice] = "フォロー解除失敗しました"
      end
    end
  end
  
end
