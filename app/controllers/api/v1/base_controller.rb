class Api::V1::BaseController < ActionController::Base
  respond_to :json, :xml
  before_action :authenticate_user_from_token!
  before_action :authorize_admin!, except: [:index, :show]

  private

  def authenticate_user_from_token!
    @current_user = User.find_by_authentication_token(params[:token])
    respond_with({:error => "Token is invalid."}) unless @current_user
  end

  def authorize_admin!
    unless @current_user.admin?
      error = { error: "You must be admin to do that." }
      warden.custom_failure!
      render params[:format].to_sym => error, status: 401
    end
  end

  def current_user
    @current_user
  end
end