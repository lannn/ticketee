class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all(order: "email")
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render action: "new"
    end
  end

  private
  def user_params
    params.required(:user).permit(:email, :password)
  end
end
