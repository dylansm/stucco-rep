class Dashboard::Admin::UsersController < ApplicationController
  before_filter :authenticate_user!

  def manage_users
    @delete_confirm = t("links.dashboard.users.delete-confirm")
    @reactivate = t("links.dashboard.users.reactivate")
    @suspend = t("links.dashboard.users.suspend")
    @users = User.order("last_name ASC").page(params[:page])
  end

end
