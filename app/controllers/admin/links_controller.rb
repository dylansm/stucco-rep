class Admin::LinksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    user
    #render "admin/index"
  end

  def new
    user
    @program = user.program
    @link = @program.links.build
    students
  end

  def create
    @link = Link.new(permitted_params)
    if @link.save
      flash[:notice] = "Link successfully created"
      redirect_to admin_links_path
    else
      flash[:alert] = "Please correct the errors below."
      user
      students
      render new_admin_link_path
    end
  end

  private

  def permitted_params
    params.require(:link).permit(
      :activity_name,
      :tag_id,
      :tag_url,
      :user_id
    )
  end

  def user
    @user ||= current_user
  end

  def students
    @students ||= User.not_admin
  end

end
