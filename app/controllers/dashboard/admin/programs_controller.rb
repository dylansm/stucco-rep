class Dashboard::Admin::ProgramsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @programs = Program.order("name ASC").page(params[:page])
    @delete_confirm = t("links.dashboard.manage_programs.delete-confirm")
  end

  def show
    program
  end

  def edit
    program
  end

  # put
  def update
    if program.update(permitted_params)
      redirect_to dashboard_admin_programs_path
    else
      respond_with program
    end
  end

  # PUT
  def add_existing_users
    params[:program][:user_ids].concat program.users.map(&:id)
    @program = Program.find(params[:id])
    if @program.update(permitted_params)
      if params[:program][:managers] == "true"
        redirect_to dashboard_admin_program_managers_path(program)
      else
        redirect_to dashboard_admin_program_users_path(program)
      end
    else
      respond_with program
    end
  end

  # PUT ajax
  def remove_user
    user = User.includes(:programs).find(params[:user_id])
    @program = user.programs.find(params[:id])
    @program.users.delete(user)
    respond_with :dashboard, :admin, @program
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(permitted_params)
    if @program.save
      redirect_to dashboard_admin_programs_path
    else
      respond_with @program
    end
  end

  def users
    localized_links
    @program = Program.includes(:users).find(params[:id])
    @users = @program.users.where(admin: false).page(params[:page])
  end

  def managers
    localized_links
    @program = Program.includes(:users).find(params[:id])
    @program_managers = @program.users.where(admin: true).page(params[:page])
  end

  private

  def permitted_params
    params.require(:program).permit(
      :name,
      :logo,
      :user_ids => []
    )
  end

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
    @users_remove_confirm = t("links.dashboard.manage_users.users_remove_from_program_confirm")
  end

end
