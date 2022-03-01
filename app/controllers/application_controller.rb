class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception
  # deviseコントローラーにストロングパラメータを追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 新規登録、更新時のストロングパラメーター
  protected
    def configure_permitted_parameters
      added_attrs = [ :user_name, :age, :sex, :email, :password]
      update_attrs = [ :user_name, :age, :sex, :email, :password, :image]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: update_attrs
    end
end
