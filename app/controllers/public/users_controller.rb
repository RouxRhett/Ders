class Public::UsersController < ApplicationController
  before_action :user_login_check

  def show
    @targets = current_user.targets
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
