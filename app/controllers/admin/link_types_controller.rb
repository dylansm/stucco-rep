class Admin::LinkTypesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only!
  respond_to :html, :json

  # JSON get
  def show
    @link_type = LinkType.find(params[:id])
    respond_to do |format|
      format.json { render json: @link_type }
    end
  end

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
      flash[:notice] = "Link activity type removed"
    else
      flash[:alert] = "Please specifiy a link activity type"
    end

    redirect_to new_admin_link_path
  end

  def update
    @link_type = LinkType.find(params[:id])
    if @link_type.update_attributes(permitted_params)
      flash[:notice] = "Link activity type created"
      redirect_to new_admin_link_path
    else
      flash[:alert] = "There was a problem creating the new link type"
      @link = Link.new
      @user = current_user
      @link_types = LinkType.all
      render 'admin/links/new'
    end
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
