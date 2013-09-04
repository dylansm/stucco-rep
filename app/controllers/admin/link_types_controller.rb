class Admin::LinkTypesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def create
    @link_type = LinkType.new(permitted_params)

    if @link_type.save
      flash[:notice] = "New link activity type saved."
      prep_new_link_page
      render "admin/links/new"
    else
      flash[:alert] = "There was a problem saving the new link activity type."
      prep_new_link_page
      render "admin/links/new"
    end
  end

  def destroy
    #params[:link_type][:id].delete_if { |item| item == "" }
    if params[:link_type]
      link_type = LinkType.find(params[:link_type][:id].first)
      link_type.destroy
      flash[:notice] = "Link Activity type removed"
    else
      flash[:alert] = "Please specifiy a link activity type"
    end

    redirect_to new_admin_link_path
  end

  private

  def permitted_params
    params.require(:link_type).permit(
      :id,
      :name,
      :call_to_action
    )
  end
  
end
