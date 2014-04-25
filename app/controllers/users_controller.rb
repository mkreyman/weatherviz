class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :allowed_to_edit?, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
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
    @user.update_attributes(admin: true) if User.count == 0
    if Rails.env.test? || Rails.env.development?
      @ip = "174.51.246.225"
    else
      @ip = request.remote_ip
    end
    @user.update_attributes(ip_address: @ip)

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
    if User.find(params[:id]).admin && current_user.admin?
      flash[:error] = "Cannot delete current admin"
      redirect_to users_url
    else
      User.find(params[:id]).destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      redirect_to login_url, notice: "Please log in."
    end
  end

  def admin_user
    if current_user.nil? || !current_user.admin?
      redirect_to root_url, alert: 'Not authorized'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def allowed_to_edit?
      if current_user.present? && (current_user.admin? || current_user == @user)
      else
        redirect_to(root_url, alert: 'Not authorized')
      end
    end

    def user_params
      user_parameters = [:first_name, :last_name,
                         :email, :password, :password_confirmation,
                         :omniauth, :ip_address, :latitude, :longitude]
      user_parameters << :admin if current_user && current_user.admin?
      params.require(:user).permit(*user_parameters)
    end
end
