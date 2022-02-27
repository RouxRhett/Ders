class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  # ユーザーログインチェック
  def user_login_check
    if !current_user
      flash[:danger] = 'ログインしてください'
      redirect_to new_user_session_path
    end
  end

  # 実績解除用判定メソッド(グループの分類についてはachievement.rbに記述)
  def achievement_check(group_name)
    @unlock_total = 0
    case  group_name
    when  'target_create' # 目標を設定した時、ログイン中のユーザーの目標の総数を取得
      judge_column = current_user.targets.count
      group_num    = 0
    when  'task_create' # タスクを追加した時、タスク数の取得
      judge_column = current_user.tasks.count
      group_num    = 1
    when  'target_complete' # 目標を達成した時、達成済み目標数の取得
      judge_column = current_user.targets.where(completion_status: true).count
      group_num    = 2
    end
    achievement = Achievement.where(group: group_num)
    achievement.each do |achieve|
      if judge_column >= achieve.number
        if current_user.unlock_lists.find_by(achievement_id: achieve.id)
        else
          UnlockList.create!(
            user_id: current_user.id,
            achievement_id: achieve.id
          )
          @unlock_total += 1
        end
      else
        break
      end
    end
  end
end
