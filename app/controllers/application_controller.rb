class ApplicationController < ActionController::Base

  # ログインしてなければsigninページへ飛ぶ homes＃topとaboutは除く
  before_action:authenticate_user!,except:[:top,:about]

  # devise機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

protected
  def after_sign_in_path_for(resource)
      user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
      root_path
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email,])
  end

end
