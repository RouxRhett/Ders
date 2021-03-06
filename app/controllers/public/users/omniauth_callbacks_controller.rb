class Public::Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_for(:twitter)
  end

  # common callback method
  def callback_for(service)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "#{service}".capitalize) if is_navigational_format?
      redirect_to mypage_path
    else
      session["devise.#{service}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  # 失敗した時
  def failure
    redirect_to root_path
  end
end
