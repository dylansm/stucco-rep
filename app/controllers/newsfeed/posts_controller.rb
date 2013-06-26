class Newsfeed::PostsController < ApplicationController
  before_filter :authenticate_user!

  def create
    debugger
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
      :video_provider
    )
  end
end
