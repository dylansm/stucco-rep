  class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:home, :styles]

  def home
    if user
      @post = user.posts.build
      @posts = Post.includes(:comments).order("created_at").page(params[:page])
      
      redirect_to dashboard_url
      
      #if user.admin?
        #@users ||= User.page(params[:page])
        #render "dashboard/admin"
      #else
        #render "dashboard/user"
      #end

    else
      render "pages/home"
    end
  end

  def styles
    @user = current_user
  end
  
  def newsfeed_dev
    @user = current_user
  end

  def member_directory
    @user = current_user
  end

  def student_profile
    @user = current_user
  end
  
  def dashboard_dev
    @user = current_user
  end
  
  def notification_center
    @user = current_user
  end
  
  private

  def user
    @user ||= current_user
  end

end
