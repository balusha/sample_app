class UsersController < ApplicationController

  include SessionsHelper

  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :deletion_allowed, only: [:destroy]
  before_action :unsigned_in_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to sample app!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    a = 1
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.delete params[:id]
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation);
  end

  def signed_in_user
     unless signed_in?
        store_location
        redirect_to signin_url, notice: 'Please sign in'
     end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def deletion_allowed

    user = User.find(params[:id])
    if !current_user.admin? || current_user.admin && current_user?(user)
      redirect_to root_url
    end
  end

  def unsigned_in_user
    if signed_in?
      redirect_to current_user, notice: 'You are already have an account'
    end
  end

end