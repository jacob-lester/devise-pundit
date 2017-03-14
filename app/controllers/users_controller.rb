class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :authorize_admin, only: [:new, :create]

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
  
  def create
    @user = User.new(user_params)
    authorize @user  
  end
  
  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end
  
  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
  
end
