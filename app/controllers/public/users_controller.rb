class Public::UsersController < ApplicationController
  before_action :user_login_check

  def show
    @user = current_user
    @challenge_targets = current_user.targets.where(completion_status: false).count
    @completed_targets = current_user.targets.where(completion_status: true).count
    case params[:search_flag]
    when 'all'
      @targets = current_user.targets.order(:deadline)
      @tab0 = ' active'
    when 'challenging'
      @targets = current_user.targets.where(completion_status: false).order(:deadline)
      @tab1 = ' active'
    when 'cleared'
      @targets = current_user.targets.where(completion_status: true).order(:deadline)
      @tab2 = ' active'
    when 'favorite'
      favorites = Favorite.where(user_id: current_user.id).pluck(:target_id)
      @targets = Target.find(favorites)
      @tab3 = ' active'
    else
      @targets = current_user.targets.order(:deadline)
      @tab0 = ' active'
    end
  end

  def unsubscribe
  end

  def withdraw
    user = current_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def error
  end
end
