class Public::FavoritesController < ApplicationController
  def create
    @target = Target.find(params[:target_id])
    target_favorite = Favorite.new(user_id: current_user.id, target_id: params[:target_id])
    target_favorite.save
  end

  def destroy
    @target = Target.find(params[:target_id])
    target_favorite = Favorite.find_by(user_id: current_user.id, target_id: params[:target_id])
    target_favorite.destroy
  end
end
