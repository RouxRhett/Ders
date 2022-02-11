class Public::TargetsController < ApplicationController
  def new
    # 新規登録用のインスタンス変数
    @target = Target.new
  end

  def create
    @target = Target.new(target_params)
    @target.user_id = current_user.id
    if @target.save
      flash[:notice] = '保存成功' # 後で変える TODO
      redirect_to target_path(@target)
    else
      flash[:notice] = '保存失敗' # 後で変える TODO
      # indexが存在せず、renderで対応すると失敗後リロードでエラーが出る為
      redirect_to new_target_path
    end
  end

  def show
    @target = Target.find(params[:id])
    # 自分or公開可のじゃなかったらマイぺージに飛ばす処理 TODO
  end

  def edit
    @target = Target.find(params[:id])
  end

  def update
    @target = Target.find(params[:id])
    if @target.update(target_params)
      redirect_to target_path(@target)
    else
      flash[:notice] = '更新失敗' # 後で変える TODO
      render 'edit'
    end
  end

  def destroy
    @target = Target.find(params[:id])
    @target.destroy
    redirect_to mypage_path
  end

  def confirm
  end

  def complete
  end

  private

  def target_params
    params.require(:target).permit(
      :category_id, :goal, :reason, :deadline, :completion_status, :public_status
    )
  end
end
