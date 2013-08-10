class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    user
    @notifications = Notification.joins(:users).where("dismissed = false AND user_id = #{user.id}")
  end

  private

  def user
    @user ||= current_user
  end

end
