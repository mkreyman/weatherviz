class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
        render action: 'edit'
      end
  end

  def destroy
    @user.destroy
      redirect_to users_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
          :first_name, :last_name, :email,
          :cell_phone, :city, :state,
          :password, :password_confirmation, :omniauth)
    end
end
