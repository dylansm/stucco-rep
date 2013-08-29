class Admin::LinksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    user
    @link_delete_confirm = t("links.admin.manage_links.link_delete_confirm")
    @link_types = LinkType.all.includes(:links)
  end

  def new
    prep_new_link_page
  end

  def create
    @link = Link.new(permitted_params)
    link_type = LinkType.find(params[:link][:link_type_ids])
    @link.link_types << link_type
    if @link.save
      flash[:notice] = "Link successfully created."
      redirect_to admin_links_path
    else
      flash[:alert] = "Please correct the errors below."
      prep_new_link_page
      render new_admin_link_path
    end
  end

  # DELETE :json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    render json: { deleted: true }
  end


  private

  def permitted_params
    params.require(:link).permit(
      :link_type_id,
      :tag_identifier,
      :tag_url,
      :user_id
    )
  end

end
