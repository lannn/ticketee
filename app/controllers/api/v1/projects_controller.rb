class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    respond_with(Project.for(current_user))
  end

  def create
    project = Project.create(project_params)
    if project.valid?
      respond_with(project, :location => api_v1_project_path(project))
    else
      respond_with(project)
    end
  end

  def show
    respond_with(@project, methods: "last_ticket")
  end

  def update
    @project.update_attributes(project_params)
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private

  def project_params
    params.required(:project).permit(:name)
  end

  def find_project
    begin
      @project = Project.for(current_user).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_with({ error: "The project you were looking for could not be found." }, status: 404)
    end
  end
end