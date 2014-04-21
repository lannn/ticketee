class Api::V2::BaseController < ActionController::Base
  respond_to :json, :xml
  before_action :authenticate_user_from_token!
  before_action :check_rate_limit

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

  def check_rate_limit
    if @current_user.request_count > 100
      error = { error: "Rate limit exceeded."}
      respond_with(error, status: 403)
    else
      @current_user.increment!(:request_count)
    end
  end
end