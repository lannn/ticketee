class ProjectsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :authenticate_user!, only: [:show, :index]
	before_action :find_project, :only => [:show, :edit, :update, :destroy]

  # caches_action :show, cache_path: (Proc.new do
    # project_url(params[:id]) + "/#{current_user.id}/#{params[:page] || 1}"
  # end)

	def index
	  @projects = Project.for(current_user).all
	end

	def new
	  @project = Project.new
	end

	def create
	  @project = Project.new(project_params)
	  if @project.save
	    flash[:notice] = "Project has been created."
	    redirect_to @project
	  else
	  	flash[:alert] = "Project has not been created."
	  	render :action => "new"
	  end
	end

	def show
    @tickets = @project.tickets.page(params[:page])
	end

	def edit
	end

	def update
	  if @project.update_attributes(project_params)
	    flash[:notice] = "Project has been updated."
	    redirect_to @project
	  else
	  	flash[:alert] = "Project has not been updated."
	  	render :action => "edit"
	  end
	end

	def destroy
	  @project.destroy
	  flash[:alert] = "Project has been deleted."
	  redirect_to projects_path
	end

	private
	def find_project
	  begin
      @project = Project.for(current_user).find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	    flash[:alert] = "The project you were looking for could not be found."
	    redirect_to projects_path
	  end
	end

	def project_params
	  params.required(:project).permit(:name)
	end
end
