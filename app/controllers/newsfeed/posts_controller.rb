class Newsfeed::PostsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @posts = Post.includes(:user, :comments).order("created_at ASC").page(params[:page])
    render json: @posts
  end


  def create
    @user = User.find(params[:post][:user_id])
    @user.posts << Post.new(permitted_params)
  end

  def update
  end

  private

  def permitted_params
    params.require(:post).permit(
      :title,
      :body,
      :image,
      :video_id,
      :video_provider,
      user: [
        :id
      ]
    )
  end
end
