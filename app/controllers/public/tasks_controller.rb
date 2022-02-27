class Public::TasksController < ApplicationController
  before_action :user_login_check

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      achievement_check('task_create')
      if @unlock_total != 0
        flash[:info] = '実績を' + @unlock_total.to_s + 'つ解除しました！'
      end
      flash[:success] = '追加できました!'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = '保存失敗しました。(数値は1以上で半角か確認してください)'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.require(:task).permit(
      :target_id, :name, :time
    )
  end
end
