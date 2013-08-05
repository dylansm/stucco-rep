class Admin::LinksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @user = current_user
    render "notifications/index"
  end

  def new
    @user = current_user
  end

  def create
  end

  private

  def permitted_params
    params.require(:notification).permit(
    )
  end


end
