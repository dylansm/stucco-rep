class PagesController < ApplicationController
  before_filter :authenticate_user!, only: [:user, :user_profile]

  def home
  end

  def user
    @user = current_user
  end

end
