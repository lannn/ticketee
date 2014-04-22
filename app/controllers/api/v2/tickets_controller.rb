class Api::V2::TicketsController < Api::V2::BaseController
  before_action :find_project

  def index
    respond_with(@project.tickets)
  end

  private

  def find_project
    begin
      @project = Project.for(current_user).find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      respond_with({ error: "The project you were looking for could not be found." }, status: 404)
    end
  end
end