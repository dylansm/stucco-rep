class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user

    unless @user.authentication_token.nil?
      @facebook_posts = fetch_facebook_stream(@user)
    end
  end
  
  def edit
    @method = 'put'
    @user = User.find(params[:id])
    @user_application = @user.user_application
    render "dashboard/admin/users/edit"
  end

  def new
    @user = User.new
    @user.build_user_application
    build_adobe_products
    @user.school = School.new
    render "dashboard/admin/users/new"
  end

  # POST
  def create
    @user = User.new(permitted_user_params)

    if @user.save
      flash[:notice] = t("devise.users.user.created")
      redirect_to dashboard_admin_users_path
    else
      flash[:alert] = t("devise.registrations.failure")
      render '/dashboard/admin/users/new'
    end
  end

  # PUT
  def update

    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    
    @user = User.find(params[:id])
    if @user.update_attributes(permitted_user_params)
      flash[:notice] = t("devise.users.user.updated")
      #set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      #sign_in @user, :bypass => true
      #redirect_to after_update_path_for(@user)
      redirect_to dashboard_admin_users_path
    else
      flash[:alert] = t("devise.registrations.failure")
      render "dashboard/admin/users/edit"
    end
  end

  # DELETE :json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    #TODO enable this
    #set_flash_message :notice, :updated
    
    respond_with @user
  end

  def suspend
    @user = User.find(params[:id])
    @user.update_attributes(active_for_authentication: false)
    respond_with @user
  end

  def reactivate
    @user = User.find(params[:id])
    @user.update_attributes(active_for_authentication: true)
    respond_with @user
  end

  protected

  #def user_application
    #@user_application ||= @user.build_user_application(params[:user_application])
  #end

  private

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  def fetch_facebook_stream(user)
    user.fetch_facebook_stream
  end

  def permitted_user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :admin,
      :tools,
      :school_id,
      user_application_attributes: [
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
      :tools_ids => []

    )
  end

  def build_adobe_products
    AdobeProduct.all.each do |ap|
      @user.tools.build(adobe_product: ap)
    end
  end

  def build_schools
    School.all.each do |s|
    end
  end

end
