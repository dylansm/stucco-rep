class Newsfeed::PostsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @posts = Post.includes(:user, :comments).page(params[:page])
    @num_pages = @posts.num_pages

    respond_to do |format|
      format.html
      format.json { render json: { posts: @posts, num_pages: @num_pages } }
    end

    #render json: { posts: @posts, num_pages: @num_pages }
  end

  def create
    @user = User.find(params[:post][:user_id])
    @post = Post.new(permitted_params)
    if @user.posts << @post
      redirect_to root_url
    else
      render "dashboard/admin"
    end
  end

  def update
  end

  private

  def permitted_params
    params.require(:post).permit(
      :text,
      :photo,
      :video_url,
      :user_id
    )
  end
end
