class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def show
    @user = User.find(params[:id])
    unless @user.authentication_token.nil?
      @facebook_posts = fetch_facebook_stream(@user)
    end
  end
  
  def edit
    @user = User.find(params[:id])
    render "dashboard/admin/users/edit"
  end

  def new
    render "dashboard/admin/users/new"
  end

  # POST
  def create
    @user = User.new(permitted_user_params)
    if @user.save
      redirect_to root_path
    else
      respond_with @user
    end
  end

  # PUT
  def update

    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    
    @user = User.find(params[:id])
    #params.permit!
    if @user.update_attributes(permitted_user_params)

      #TODO enable this
      #set_flash_message :notice, :updated

      # Sign in the user bypassing validation in case his password changed
      #sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  # DELETE
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    #TODO enable this
    #set_flash_message :notice, :updated
    
    respond_with @user.to_json
  end

  def suspend
  end

  private

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  def permitted_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :admin)
  end

  def fetch_facebook_stream(user)
    user.fetch_facebook_stream
  end

  #def fetch_facebook_stream(user)
    #posts = FbGraph::Query.new(
      #"SELECT message,comment_info,share_count,likes,created_time FROM stream WHERE strpos(message, '#adobehashtag') >= 0 AND source_id = #{user.uid} AND updated_time > 1350000000"
    #)
    #posts.access_token = user.authentication_token
    #posts.fetch
  #end

end
