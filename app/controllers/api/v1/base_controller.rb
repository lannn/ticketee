class Api::V1::BaseController < ActionController::Base
  respond_to :json, :xml
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    @current_user = User.find_by_authentication_token(params[:token])
    respond_with({:error => "Token is invalid."}) unless @current_user
  end

  def current_user
    @current_user
  end
end