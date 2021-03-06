class Admin::LinksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only!
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

    params[:link][:tag_url] = "http://" + params[:link][:tag_url] unless /https?:\/\// =~ params[:link][:tag_url]
    @link = Link.new(permitted_params)

    unless params[:link][:link_type_ids].empty?
      link_type = LinkType.find(params[:link][:link_type_ids])
      @link.link_types << link_type
    end

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
