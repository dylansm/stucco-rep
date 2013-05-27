class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:home]

  def home
    @user = current_user
    if @user
      if @user.admin?
        @users ||= User.all
        render "dashboard/admin"
      else
        render "dashboard/user"
      end
    else
      render "pages/home"
    end
  end

  def user
    @user = current_user
  end

  def manage_users
    @users = User.all.page(params[:page])
  end

end
