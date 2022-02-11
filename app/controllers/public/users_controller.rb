class Public::UsersController < ApplicationController
  def show
    @targets = current_user.targets
  end

  def unsubscribe
  end

  def withdraw
  end
end
