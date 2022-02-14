class Public::UsersController < ApplicationController
  before_action :user_login_check

  def show
    @user = current_user
    @targets = current_user.targets
    @challenge_targets = current_user.targets.where(completion_status: false).count
    @completed_targets = current_user.targets.where(completion_status: true).count
  end

  def unsubscribe
  end

  def withdraw
    user = current_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
end
