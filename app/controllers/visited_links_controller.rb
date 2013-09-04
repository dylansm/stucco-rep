class VisitedLinksController < ApplicationController
  respond_to :html, :json

  def link
    @link = Link.find(params[:id])
    debugger
    redirect_to @link.tag_url
  end

  def social_link
    @link = Link.find(params[:id])
    case params[:social_id]
    when "facebook"
      fb_link = "http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://www.google.com&p[title]=#{@link.link_types.first.name}"
      debugger
      redirect_to fb_link
    when "twitter"
    end
  end

  private

  def permitted_params
    params.require(:link).permit(
      :id
    )
  end

end
