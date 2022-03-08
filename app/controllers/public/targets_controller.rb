class Public::TargetsController < ApplicationController
  before_action :user_login_check

  def index
    @categories = Category.all
    # タブ(挑戦中・達成済み)が選ばれた時のみ使用
    if params[:filter]
      @cat_id = params[:filter]
    else
      @cat_id = nil
    end

    # 検索条件の定義と該当ボタンのクラス追加
    case params[:filter_type]
    when 'true'
      @filter_type = true
      @tab1 = ' active'
    when 'false'
      @filter_type = false
      @tab0 = ' active'
    else
      @filter_type = false
      @tab0 = ' active'
    end

    # 条件を元に目標の検索を行う。指定カテゴリの名前もここで定義
    if @cat_id
      targets = Target.where(
        completion_status: @filter_type, category_id: @cat_id, public_status: true
      ).includes([:category])
      @targets = targets.order(:deadline).page(params[:page])
      @category_name = Category.find(@cat_id).name
    else
      # 初期値
      targets = Target.where(completion_status: @filter_type, public_status: true)
      @targets = targets.order(:deadline).includes([:category]).page(params[:page])
      @category_name = '全て'
    end
  end

  def new
    # 新規登録用のインスタンス変数
    @target = Target.new
  end

  def create
    @target = Target.new(target_params)
    @target.user_id = current_user.id
    if @target.save
      achievement_check('target_create')
      if @unlock_total != 0
        flash[:info] = '実績を' + @unlock_total.to_s + 'つ解除しました！'
      end
      flash[:success] = '保存成功' # 後で変える TODO
      redirect_to target_path(@target)
    else
      render 'new'
      # redirectで対応する場合は以下のコードを利用
      # flash[:danger] = '保存失敗'
      # redirect_to new_target_path
    end
  end

  def show
    @target = Target.find(params[:id])
    if @target.public_status == true || @target.user == current_user
      @task = Task.new
      @tasks = @target.tasks.page(params[:page])
      # ゼロ徐算回避
      if @target.tasks.count == 0
        @task_average = 0
      else
        # これをviewにそのまま書くとゼロ除算エラーが発生する
        @task_average = (@target.tasks.sum(:time).to_f / @target.tasks.count.to_f).to_i
      end
    else
      flash[:danger] = '指定された目標は非公開です'
      redirect_to targets_path
    end
  rescue
    flash[:danger] = '指定された目標は存在しません'
    redirect_to targets_path
  end

  def edit
    @target = Target.find(params[:id])
    if @target.user == current_user
      render 'edit'
    else
      flash[:danger] = '権限がありません'
      redirect_to mypage_path
    end
  rescue
    # 存在しないIDの編集画面を表示しようとした時
    flash[:danger] = '指定された目標が存在しません'
    redirect_to mypage_path
  end

  def update
    @target = Target.find(params[:id])
    if @target.user == current_user
      if @target.update(target_params)
        flash[:success] = '更新成功' # 後で変える TODO
        redirect_to target_path(@target)
      else
        # バリデーションエラーを表示したためフラッシュメッセージをコメントアウト
        # flash[:danger] = '更新失敗' # 後で変える TODO
        render 'edit'
      end
    else
      flash[:danger] = '権限がありません'
      redirect_to mypage_path
    end
  end

  def destroy
    target = Target.find(params[:id])
    target.destroy
    flash[:danger] = '更新成功'
    redirect_to mypage_path
  end

  def error
  end

  def confirm
    @target = Target.find(params[:id])
  end

  def complete
    @target = Target.find(params[:id])
    @target.update(completion_status: true)
    achievement_check('target_complete')
    if @unlock_total != 0
      flash[:info] = '実績を' + @unlock_total.to_s + 'つ解除しました！'
    end
  end

  private

  def target_params
    params.require(:target).permit(
      :category_id, :goal, :reason, :deadline, :completion_status, :public_status, :num_tgt
    )
  end
end
