class Dashboard::Admin::SchoolsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @delete_confirm = t("links.dashboard.manage_schools.delete-confirm")
    @schools = School.includes(:users).order("schools.name ASC").page(params[:page])
  end

  def edit
    school
  end

  def update
    if school.update(permitted_params)
      redirect_to dashboard_admin_schools_path
    else
      respond_with school
    end
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
end
