class Admin::SchoolsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    user
    @delete_confirm = t("links.dashboard.manage_schools.delete-confirm")
    @schools = School.includes(:users).order("schools.name ASC").page(params[:page])
  end

  def edit
    user
    school
  end

  def new
    user
    @school = School.new
  end

  def update
    if school.update(permitted_params)
      redirect_to dashboard_admin_schools_path
    else
      respond_with school
    end
  end

  def create
    @school = School.new(permitted_params)
    if @school.save
      flash[:notice] = "School successfully added"
      redirect_to admin_schools_path
    else
      flash[:alert] = "Please correct the errors below"
      user
      respond_with @school
    end
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    render json: { deleted: true }
  end

  def users
    @school = School.includes(:users).find(params[:id])
    @users = @school.users.page(params[:page])
  end

  private

  def permitted_params
    params.require(:school).permit(
      :name,
      :school_logo
    )
  end

  def school
    @school ||= School.includes(:users).find(params[:id])
  end

  def user
    @user ||= current_user
  end
end
