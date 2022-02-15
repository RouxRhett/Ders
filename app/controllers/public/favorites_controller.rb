class Public::FavoritesController < ApplicationController
  def create
    target_favorite = Favorite.new(user_id: current_user.id, target_id: params[:target_id])
    target_favorite.save
    redirect_to target_path(params[:target_id])
  end

  def destroy
    target_favorite = Favorite.find_by(user_id: current_user.id, target_id: params[:target_id])
    target_favorite.destroy
    redirect_to target_path(params[:target_id])
  end
end
