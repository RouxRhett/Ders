class Public::UnlockListsController < ApplicationController
  before_action :user_login_check

  def index
    @unlock_lists = current_user.unlock_lists.includes([:achievement])
  end
end
