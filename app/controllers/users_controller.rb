#class UsersController < Devise::RegistrationsController
class UsersController < DeviseController
  before_filter :authenticate_user!, only: [ :show ]

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
    #@user = current_user
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
  end
end
