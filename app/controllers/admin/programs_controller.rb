class Admin::ProgramsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    user
    @programs = Program.order("name ASC").page(params[:page])
    @delete_confirm = t("links.dashboard.manage_programs.delete-confirm")
  end

  #def show
    #user
    #program
  #end

  def edit
    user
    program
  end

  # put
  def update
    if program.update(permitted_params)
      redirect_to admin_programs_path
    else
      respond_with :admin, program
    end
  end

  # PUT
  def add_existing_users
    @program = Program.find(params[:id])
    params[:program][:user_ids].concat @program.users.map(&:id)
    if @program.update(permitted_params)
      redirect_to admin_program_users_path(program)
    else
      respond_with :admin, program
    end
  end

  def add_existing_managers
    @program = Program.find(params[:id])
    params[:program][:user_ids].concat @program.users.where(admin: true).map(&:id)
    if @program.update(permitted_params)
      redirect_to admin_program_managers_path(program)
    else
      respond_with :admin, program
    end
  end

  # PUT ajax
  def remove_user
    user = User.includes(:programs).find(params[:user_id])
    if user.programs.count == 1
      if user == current_user
        render json: { removed: false, message: t('alerts.your_last_program') }
      else
        render json: { removed: false, message: t('alerts.user_last_program') }
      end
    else
      @program = user.programs.find(params[:id])
      @program.users.delete(user)
      render json: { removed: true }
    end
  end

  def new
    user
    @program = Program.new
  end

  def create
    @program = Program.new(permitted_params)
    if @program.save
      redirect_to admin_programs_path
    else
      respond_with @program
    end
  end

  def destroy
    @program = Program.find(params[:id])
    if Program.count == 1
      render json: { deleted: false, message: t('alerts.there_must_be_one_program') }
    elsif @program.users.any?
      render json: { deleted: false, message: t('alerts.remove_users_before_delete') }
    else
      program.destroy
      render json: { deleted: true }
    end
  end

  def users
    user
    localized_links
    @program = Program.includes(:users).find(params[:id])
    @users = @program.users.where(admin: false).page(params[:page])
  end

  def managers
    user
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

  def user
    @user ||= current_user
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
