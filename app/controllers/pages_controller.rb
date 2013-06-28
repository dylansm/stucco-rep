class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:home]

  def home
    if user
      @post = user.posts.build
      @posts = Post.includes(:comments).order("published_at").page(params[:page])
      if user.admin?
        #TODO paginate this
        @users ||= User.all
        render "dashboard/admin"
      else
        render "dashboard/user"
      end
    else
      render "pages/home"
    end
  end

  private

  def user
    @user ||= current_user
  end

end
