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

  private

  def permitted_params
    params.require(:program).permit(
      :name,
      :logo
    )
  end

  def program
    @program ||= Program.find(params[:id])
  end

end
