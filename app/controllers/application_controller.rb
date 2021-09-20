class ApplicationController < ActionController::Base

  # ログインしてなければtopページへ飛ぶ
  before_action:authenticate_user!,expect:[:top] 
  
  # devise機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
      user_path(current_user.id)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end

end
