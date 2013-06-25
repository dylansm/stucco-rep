class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_filter :configure_devise_permitted_params, if: :devise_controller?
  before_action :get_program

  protected

  def configure_devise_permitted_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :current_password, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email) }
    devise_parameter_sanitizer.for(:password) { |u| u.permit(:password, :password_confirmation) }
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def get_program
    if current_user
      @program = Program.find(current_user.current_program_id)
    end
  end
end
