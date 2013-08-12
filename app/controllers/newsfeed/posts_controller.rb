class Newsfeed::PostsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @post = user.posts.build
    @posts = Post.includes(:user, :comments, :likes, :rating).page(params[:page])
    @num_pages = @posts.num_pages

    respond_to do |format|
      format.html
      format.json { render json: @posts, each_serializer: PostSerializer }
    end
  end

  def create
    @user = User.find(params[:post][:user_id])
    @post = Post.new(permitted_params)
    if @user.posts << @post
      respond_to do |format|
        format.html { redirect_to newsfeed_url }
        format.json { render json: @post }
      end
    else
      #redirect_to newsfeed_url
      render "newsfeed/posts/index.html"
    end
  end

  # POST AJAX update
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(permitted_params)
      render json: @post, serializer: PostSerializer
    else
      render json: { updated: false, message: "Something went horribly wrong."}
    end
  end

  # DELETE AJAX
  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: { deleted: true }
  end

  # POST AJAX create like
  def likes
    params.merge!({ user_id: current_user.id })
    @liked_post = Post.find(params[:post_id])
    like = Like.where("post_id = ? AND user_id = ?", params[:post_id], params[:user_id])
    if like.any?
      destroy_like like
    else
      like = Like.create({ user_id: params[:user_id], post_id: params[:post_id]})
    end
    render json: @liked_post, serializer: LikedPostSerializer
  end

  private

  def destroy_like(like)
    like.each do |like|
      like.destroy
    end
  end

  def permitted_params
    params.require(:post).permit(
      :post_id,
      :text,
      :photo,
      :post_image,
      :remove_image,
      :video_url,
      :user_id,
      :likes
    )
  end

  def user
    @user ||= current_user
  end

end
