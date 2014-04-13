class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path,
                  notice: "Thank you for signing up #{@user.first_name}."
    else
      render :new
    end
  end

  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      redirect_to login_url, notice: "Please log in."
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
      redirect_to(login_url) unless current_user?(@user)
    end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

    def user_params
      params.require(:user).permit(
          :first_name, :last_name, :email,
          :cell_phone, :city, :state,
          :password, :password_confirmation, :omniauth)
    end
end
