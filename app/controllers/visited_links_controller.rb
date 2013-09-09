class VisitedLinksController < ApplicationController
  respond_to :html, :json

  def link
    @link = Link.find(params[:id])
    if params[:social_name]
      social_link = build_social_link(params[:social_name])
    end

    unless /#{APP_CONFIG["url"]}|#{APP_CONFIG["dev_url"]}|#{APP_CONFIG["staging_url"]}/ =~ request.referrer
      if !social_link || (social_link && params[:share] == @link.id.to_s)
        VisitedLink.create(link: @link, user: @link.user, social_platform: params[:social_name])
      end
    end
    
    if social_link && !params[:share]
      redirect_to social_link
    else
      redirect_to @link.tag_url
    end
  end


  private

  def permitted_params
    params.require(:link).permit(
      :id
    )
  end

  def build_social_link(social_name)
    link_type = @link.link_types.first
    case social_name
    when "facebook"
      URI::escape("http://www.facebook.com/sharer/sharer.php?s=100&p[url]=#{request.protocol}#{request.host_with_port}/link/#{@link.id}/facebook/#{@link.id}&p[title]=#{link_type.name}&p[summary]=#{link_type.call_to_action}")
    when "twitter"
      URI::escape("http://twitter.com/home?status=#{link_type.call_to_action} #{@link.tag_url}/twitter/#{@link.id}")
    end
  end

end
