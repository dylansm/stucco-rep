class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @users = User.all
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user

    unless authentication_token.nil?
      @facebook_posts = fetch_facebook_stream(@user)
    end
  end

  def authentication_token
    @user.authentication_token
  end

  # PUT
  def create_post
    if @user.update_attributes(permitted_user_params)
      respond_with @post
    end
  end

  private

  def fetch_facebook_stream(user)
    user.fetch_facebook_stream
  end

  def permitted_user_params
    params.require(:user).permit(
      :id,
      :first_name,
      :last_name,
      :email,
      :mobile_phone,
      :admin,
      :school_id,
      :avatar,
      tools_attributes: [
        :id,
        :skill_level,
        :adobe_product_id
      ],
      user_application_attributes: [
        :id,
        :gender,
        :mobile_phone,
        :street_address,
        :street_address2,
        :city,
        :state,
        :postal_code,
        :country,
        :planned_grad_year,
        :planned_grad_term,
        :major,
        :minor,
        :gpa,
        :num_facebook_friends,
        :num_instagram_followers,
        :num_twitter_followers,
        :other_social_sites,
        :extracurriculars,
        :extracurricular_leadership,
        :leadership_description,
        :skill_level,
        :reference_name,
        :reference_relationship,
        :reference_email,
        :reference_phone,
        :avatar,
        :advisory_board_application,
        :resume
      ],
      :program_ids => [],
      program_attributes: [
        :id
      ]
    )
  end
end
