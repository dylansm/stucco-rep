class Admin::NotificationsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    user
    if user.admin?
      @notifications = user.authored_notifications
    else
      @notifications = user.notifications
    end
    render "notifications/index"
  end

  def new
    user
    @notification = current_user.authored_notifications.build()
    students
  end

  def create
    @notification = Notification.new(permitted_params) 
    if @notification.save
      flash[:notice] = "Notification sent"
      redirect_to root_path
    else
      flash[:alert] = "Please correct the errors below."
      @user = current_user
      students
      render 'admin/notifications/new'
    end
  
  end

  private

  def permitted_params
    params.require(:notification).permit(
      :title,
      :text, 
      :notifier_id,
      user_ids: []
    )
  end

  def user
    @user ||= current_user
  end

  def students
    @students ||= User.where(admin: false)
  end

end
