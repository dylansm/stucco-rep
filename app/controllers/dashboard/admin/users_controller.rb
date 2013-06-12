class Dashboard::Admin::UsersController < ApplicationController
  before_filter :authenticate_user!

  def manage_users
    @delete_confirm = t("links.dashboard.manage_users.delete-confirm")
    @reactivate = t("links.dashboard.manage_users.reactivate")
    @suspend = t("links.dashboard.manage_users.suspend")
    @users = User.order("last_name ASC").page(params[:page])
  end

end
