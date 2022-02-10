class Public::TargetsController < ApplicationController
  def new
    Target.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def confirm
  end

  def complete
  end

  private

  def target_params
    params.require(:target).permit(:user_id, :category_id, :goal, :reason, :deadline, :completion_status, :public_status)
  end
end
