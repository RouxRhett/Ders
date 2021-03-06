class Public::UsersController < ApplicationController
  before_action :user_login_check

  def show
    @user = current_user
    @challenge_targets = current_user.targets.where(completion_status: false).count
    @completed_targets = current_user.targets.where(completion_status: true).count
    case params[:search_flag]
    when 'all'
      @targets = current_user.targets.order(:deadline).includes([:category]).page(params[:page])
      @tab0 = ' active'
    when 'challenging'
      targets = current_user.targets.where(completion_status: false).order(:deadline)
      @targets = targets.includes([:category]).page(params[:page])
      @tab1 = ' active'
    when 'cleared'
      targets = current_user.targets.where(completion_status: true).order(:deadline)
      @targets = targets.includes([:category]).page(params[:page])
      @tab2 = ' active'
    when 'favorite'
      @targets = current_user.favorite_targets.includes([:category]).page(params[:page])
      @tab3 = ' active'
    else
      @targets = current_user.targets.order(:deadline).includes([:category]).page(params[:page])
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
