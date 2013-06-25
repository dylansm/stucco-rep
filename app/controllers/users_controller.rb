class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user

    unless authentication_token.nil?
      @facebook_posts = fetch_facebook_stream(@user)
    end
  end

  def authentication_token
    @user.authentication_token
  end

  private

  def fetch_facebook_stream(user)
    user.fetch_facebook_stream
  end

end
