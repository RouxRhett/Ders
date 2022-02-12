class ApplicationController < ActionController::Base
  # ユーザーログインチェック
  def user_login_check
    if !current_user
      flash[:notice] = 'ログインしてください'
      redirect_to new_user_session_path
    end
  end
end
