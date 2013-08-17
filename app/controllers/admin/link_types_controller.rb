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

  private

  def permitted_params
    params.require(:link_type).permit(
      :id,
      :name
    )
  end
  
end
