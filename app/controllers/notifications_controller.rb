class NotificationsController < ApplicationController

  def index
    user
    if user.admin?
      redirect_to admin_notifications_path
    else
      @notifications = user.notifications.page(params[:page])
    end
  end

end
