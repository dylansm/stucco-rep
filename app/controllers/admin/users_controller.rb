class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @user = current_user
    localized_links
    @programs = Program.all
    @program_managers = User.where(admin: true).order("last_name ASC")
    @students = User.where(admin: false).order("last_name ASC").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @user_application = @user.user_application
    build_adobe_products
    render "admin/users/edit"
  end

  # PUT
  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(params[:id])
    map_skills_to_adobe_products

    if @user.update_attributes(permitted_user_params)
      flash[:notice] = t("devise.users.user.updated")
      redirect_to admin_users_path
    else
      flash[:alert] = t("devise.registrations.failure")
      render "admin/users/edit"
    end
  end

  def new
    @user = User.new
    @user.build_user_application
    build_adobe_products
    @user.school = School.new
    @user.programs.build id: params[:program_id] if params[:program_id]
    render "admin/users/new"
  end

  # POST
  def create
    #TODO
    # uncomment program chooser in form and enable mutliple programs
    params[:user][:program_ids] = ["1"]
    
    @user = User.new(permitted_user_params)
    @user[:program_id]

    if @user.save
      flash[:notice] = t("devise.users.user.created")
      redirect_to admin_users_path
    else
      flash[:alert] = t("devise.registrations.failure")
      render 'admin/users/new'
    end
  end

  # DELETE :json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    # flash won't magically appear on page
    #flash[:notice] = t("devise.registrations.destroyed")
    
    #respond_with :admin, @user
    render json: { deleted: true }
  end

  def suspend
    @user = User.find(params[:id])
    unless @user == current_user
      @user.update_attributes(active_for_authentication: false)
      respond_with @user
    end
  end

  def reactivate
    @user = User.find(params[:id])
    @user.update_attributes(active_for_authentication: true)
    respond_with @user
  end

  # GET
  def not_in_program
    @program = Program.find(params[:program_id])
    @users = User.not_in_program(program)
    render json: @users
  end

  def not_admin_in_program
    @program = Program.find(params[:program_id])
    @users = User.not_in_program(program, true)
    render json: @users
  end

  def current_program
    new_program_id = params[:user][:current_program_id]
    if user.update_column(:current_program_id, new_program_id)
      redirect_to root_path
    else
      respond_with user
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def program
    @program ||= Program.find(params[:program_id])
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
    @users_remove_confirm = t("links.dashboard.manage_users.users_remove_from_program_confirm")
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
      :bio,
      :remove_avatar,
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
        :instagram_username,
        :twitter_username,
        :behance_profile_url,
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

  def adobe_products
    @adobe_products ||= AdobeProduct.order("name ASC")
  end

  def build_adobe_products
    adobe_products.each do |ap|
      @user.tools.build(adobe_product: ap) unless @user.tools.map { |t| t.adobe_product_id }.include? ap.id
    end
  end

  def map_skills_to_adobe_products
    if params[:user][:tools_attributes]
      tool_attribs = params[:user][:tools_attributes]
      tool_attribs.keys.each do |k|
        unless tool_attribs[k][:id].nil?
          Tool.find(tool_attribs[k][:id]).update_column("skill_level", tool_attribs[k][:skill_level])
        else
          tool_attribs[k][:adobe_product_id] = adobe_product_id_at_index(k.to_i)
        end
      end
    end
  end

  def adobe_product_id_at_index(i)
    adobe_products[i].id.to_s
  end

end
