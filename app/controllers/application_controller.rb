class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_filter :configure_devise_permitted_params, if: :devise_controller?
  before_action :get_program

  protected

  def prep_new_link_page
    user
    program
    students
    @link_types = LinkType.all
    @link_type = LinkType.new
    link_user = User.new
    @link ||= link_user.links.build
  end

  def configure_devise_permitted_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :current_password, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email) }
    devise_parameter_sanitizer.for(:password) { |u| u.permit(:password, :password_confirmation) }
  end

  def user
    @user ||= current_user
  end

  def students
    @students ||= User.not_admin
  end

  def program
    @program ||= @user.program
  end
  
  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def get_program
    if current_user
      @program = current_user.program || find_another_program
      unless @program
        sign_out_and_redirect root_path
        flash[:alert] = t("alerts.no_current_program")
      end
    end
  end

  def find_another_program
    program = current_user.programs.first
    current_user.update_column(:current_program_id, program.id) if program
    program
  end

end
