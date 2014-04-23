class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project
  before_action :find_ticket, only: [:show, :edit, :update, :destroy, :remove_tag]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]
  before_action :authorize_delete!, only: [:destroy]
  cache_sweeper :tickets_sweeper, only: [:create, :update, :destroy]

  etag { @ticket }
  etag { current_user.id }

  def show
    @comment = @ticket.comments.build
    @states = State.all
    fresh_when(@ticket)
  end

	def new
    @ticket = @project.tickets.build
    @ticket.assets.build
	end

  def create
    @ticket = @project.tickets.build(ticket_params.merge!(user: current_user))
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @ticket.update_attributes(ticket_params)
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:alert] = "Ticket has been deleted."
    redirect_to @project  
  end

  def remove_tag
    @ticket.tag_list.remove(params[:tag_name])
    @ticket.save
    render nothing: true
  end

  private
  def find_project
    begin
      @project = Project.for(current_user).find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to root_path
    end
  end

  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end 

  def ticket_params
    params.required(:ticket).permit!
  end

  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
      flash[:alert] = "You cannot create tickets on this project."
      redirect_to @project 
    end
  end

  def authorize_update!
    if !current_user.admin? && cannot?(:"update tickets", @project)
      flash[:alert] = "You cannot update tickets on this project."
      redirect_to @project
    end
  end

  def authorize_delete!
    if !current_user.admin? && cannot?(:"delete tickets", @project)
      flash[:alert] = "You cannot delete tickets on this project."
      redirect_to @project
    end
  end
end
