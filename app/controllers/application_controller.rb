class ApplicationController < ActionController::Base
  # ユーザーログインチェック
  def user_login_check
    if !current_user
      flash[:notice] = 'ログインしてください'
      redirect_to new_user_session_path
    end
  end

  # 実績解除用判定メソッド
  def achievement_check(group_name)
    case  group_name
    when  'target_create'
      judge_column = current_user.targets.count
      group_num    = 0
    when  'task_create'
      judge_column = current_user.tasks.count
      group_num    = 1
    when  'target_complete'
      judge_column = current_user.targets.where(completion_status: true).count
      group_num    = 2
    end
    achievement = Achievement.where(group: group_num)
    achievement.each do |achieve|
      if judge_column >= achieve.number
        UnlockList.create!(
          user_id: current_user.id,
          achievement_id: achieve.id
        )
      else
        break
      end
    end
  end
end
