class Newsfeed::CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(permitted_params)
    @comment.user = current_user
    post.comments << @comment
    render json: @comment
  end

  private

  def permitted_params
    params.require(:comment).permit(
      :text
    )
  end

end
