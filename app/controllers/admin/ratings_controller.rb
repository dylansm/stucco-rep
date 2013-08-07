class Admin::RatingsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def rate_post
    post = Post.find(params[:id])
    @rating = post.build_rating(rating: params[:rating])
    if post.save
      render json: @rating
    else
      render json: { error: "Couldn't save rating" }
    end
  end

  def update_rated_post
    post = Post.find(params[:id])
    @rating = post.rating
    if @rating.update_column("rating", params[:rating])
      render json: @rating
    else
      render json: { error: "Couldn't save rating" }
    end
  end

  private

  def permitted_params
    params.require(:rating).permit(
      :id,
      :rating
    )
  end
end
