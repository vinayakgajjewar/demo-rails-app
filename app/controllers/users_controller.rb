class UsersController < ApplicationController
  # skip_before_action :require_login, only: [:login]
  def login
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :login, status: :unprocessable_entity
    end
  end
  def create
    # puts params[:user][:username]
    session[:current_username] = params[:user][:username]
    redirect_to root_path
  end
  def logout
    session[:current_username] = nil
  end
  private
  def user_params
    # params.require(:user).permit(:username)
    params.permit(:username)
  end
end
