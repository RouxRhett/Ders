class Public::UsersController < ApplicationController
  before_action :user_login_check

  def show
    @targets = current_user.targets
  end

  def unsubscribe
  end

  def withdraw
  end
end
