class Admin::NotificationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only!
  respond_to :html, :json

  def index
    user
    @notifications = user.authored_notifications.page(params[:page])
    render "notifications/index"
  end

  def new
    user
    @notification = current_user.authored_notifications.build()
    students
  end

  def create
    if params[:all_students] == "1"
      params[:notification][:user_ids].concat User.not_admin.map(&:id)
    end

    @notification = Notification.new(permitted_params) 
    
    if @notification.save
      flash[:notice] = "Notification sent"
      redirect_to notifications_path
    else
      flash[:alert] = "Please correct the errors below."
      @user = current_user
      students
      render new_admin_notification_path
    end
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    render json: { deleted: true }
  end
    
  def dismiss
    notifications_users = NotificationsUsers.where("notification_id = ? AND user_id = ?", params[:id], current_user.id).first
    if notifications_users.update_column(:dismissed, true)
      render json: { dismissed: true }
    else
      render json: { error: "Unable to update notification users."}
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
