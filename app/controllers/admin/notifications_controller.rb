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
    #@notification = current_user.notifications.build(notifier_id: current_user.id)
    #@notification = current_user.notifications.build(notifier: current_user)
    @users = User.where(admin: false)
    @notification = current_user.notifications.build
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
