class TicketsController < ApplicationController
  before_action :find_project
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]

  def show
  end

	def new
    @ticket = @project.tickets.build
	end

  def create
    @ticket = @project.tickets.build(ticket_params)
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render :action => "new"
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.required(:ticket).permit(:title, :description)
  end
end
