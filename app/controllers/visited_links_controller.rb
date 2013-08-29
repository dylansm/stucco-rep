class VisitedLinksController < ApplicationController
  respond_to :html, :json

  def link
    @link = Link.find(params[:id])
    debugger
    redirect_to @link.tag_url
  end

  private

  def permitted_params
    params.require(:link).permit(
      :id
    )
  end

end
