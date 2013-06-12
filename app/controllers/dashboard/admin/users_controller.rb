class Dashboard::Admin::UsersController < ApplicationController
  before_filter :authenticate_user!

  def manage_users
    localized_links
    @program_managers = ProgramManager.includes(:user).order("users.last_name ASC").uniq
    @users = User.order("last_name ASC").page(params[:page])
  end

  def program_users
    localized_links
    @users = program.users.page(params[:page])
  end

  def program_managers
    localized_links
    @program_managers = program.program_managers.page(params[:page])
  end

  private

  def program
    @program ||= Program.find(params[:id])
  end

  def localized_links
    @reactivate ||= t("links.dashboard.manage_users.reactivate")
    @suspend ||= t("links.dashboard.manage_users.suspend")
    @users_suspend_confirm = t("links.dashboard.manage_users.users-suspend-confirm")
    @users_reactivate_confirm = t("links.dashboard.manage_users.users-reactivate-confirm")
    @managers_suspend_confirm = t("links.dashboard.manage_users.managers-suspend-confirm")
    @managers_reactivate_confirm = t("links.dashboard.manage_users.managers-reactivate-confirm")
    @users_delete_confirm = t("links.dashboard.manage_users.users-delete-confirm")
    @managers_delete_confirm = t("links.dashboard.manage_users.managers-delete-confirm")
  end

end
