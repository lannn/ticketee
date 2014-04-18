class FilesController < ApplicationController
  before_action :authenticate_user!

  def show
    asset = Asset.find(params[:id])
    if can?(:view, asset.ticket.project)
      send_file asset.asset.path, filename: asset.asset_file_name, content_type: asset.asset_content_type
    else
      flash[:alert] = "The asset you were looking for could not be found."
      redirect_to root_path
    end
  end

  def new
    debugger
    @ticket = Ticket.new
    asset = @ticket.assets.build
    render "files/form", asset: asset, number: params[:number].to_i
  end
end
