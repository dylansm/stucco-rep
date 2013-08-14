class Admin::LinksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    user
    render "notifications/index"
  end

  def new
    user
    @program = user.program
    @link = @program.links.build
  end

  def create
  end

  private

  def permitted_params
    params.require(:notification).permit(
    )
  end

  def user
    @user = current_user
  end

end
