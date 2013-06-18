class Dashboard::Admin::UsersController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def index
    localized_links
    #@program_managers = ProgramManager.includes(:user).order("users.last_name ASC")
    @program_managers = ProgramManager.joins(:user).select("DISTINCT users.*")
    @programs = Program.all
    @users = User.order("last_name ASC").page(params[:page])
  end

  def program_users
    localized_links
    @users = program.users.page(params[:page])
  end

  def program_managers
    localized_links
    @program_managers = program.program_managers.page(params[:page])
  end

  def school_users
    #localized_links
    #@school = School.includes(:users).find(params[:id]).page(params[:page])
    @school = School.includes(:users).find(params[:id])
    @users = @school.users.page(params[:page])
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

      unless @user.admin
        ProgramManager.where("user_id = ?", @user.id).each { |pm| pm.destroy }
      end

      flash[:notice] = t("devise.users.user.updated")
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

    # flash won't magically appear on page
    flash[:notice] = t("devise.registrations.destroyed")
    
    respond_with :dashboard, :admin, @user
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

  private

  def program
    @program ||= Program.find(params[:id])
  end

  def localized_links
    @reactivate ||= t("links.dashboard.manage_users.reactivate")
    @suspend ||= t("links.dashboard.manage_users.suspend")
    @users_suspend_confirm = t("links.dashboard.manage_users.users-suspend-confirm")
    @users_reactivate_confirm = t("links.dashboard.manage_users.users-reactivate-confirm")
    @managers_suspend_confirm = t("links.dashboard.manage_users.managers-suspend-confirm")
    @managers_reactivate_confirm = t("links.dashboard.manage_users.managers-reactivate-confirm")
    @users_delete_confirm = t("links.dashboard.manage_users.users-delete-confirm")
    @managers_delete_confirm = t("links.dashboard.manage_users.managers-delete-confirm")
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

end
