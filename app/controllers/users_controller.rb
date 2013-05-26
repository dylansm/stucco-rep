class UsersController < DeviseController
  before_filter :authenticate_user!, only: [ :show ]

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  # POST
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path
    else
      puts "<<<<<<<PROBLEM"
    end
  end

  # PUT
  def update

    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    
    @user = User.find(params[:id])
    params.permit!
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      #sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end
end
