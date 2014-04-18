class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ticket

  def create
    @comment = @ticket.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      @states = State.all
      flash[:notice] = "Comment has not been created."
      render "tickets/show"
    end 
  end

  private
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.required(:comment).permit!
  end
end
