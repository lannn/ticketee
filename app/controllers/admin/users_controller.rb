class Admin::UsersController < Admin::BaseController
  before_action :find_user, :only => [:show, :edit, :update, :destroy]
  def index
    @users = User.all(order: "email")
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)
    set_admin
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render action: "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password) 
      user_params.delete(:password_confirmation)
    end
    set_admin
    if @user.update_attributes(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render action: "edit"
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "You cannot delete yourself."
    else
      @user.destroy
      flash[:notice] = "User has been deleted."
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.required(:user).permit(:email, :password, :password_confirmation, :admin)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def set_admin
    @user.admin = user_params[:admin] == "1"
  end
end
