class Admin::NotificationsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    user
    @notifications = Notification.all
    @users = User.where(admin: false)
    render "notifications/index"
  end

  def new
    user
    @notification = Notification.new()
    @notifier = current_user
    @notification.build_notifier(user: current_user)
    @users = User.where(admin: false)
    @schools = School
  end

  def create
    debugger
  
  end

  private

  def permitted_params
    params.require(:notification).permit(
    )
  end

  def user
    @user ||= current_user
  end

end
