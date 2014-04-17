require 'spec_helper'

describe TicketsController do
  let(:user) { create_user! }
  let(:project) { create(:project) }
  let(:ticket) { create(:ticket, project: project, user: user) }

  context "standard users" do
    it "cannot access a ticket for a project" do
      sign_in(:user, user)
      get :show, id: ticket.id, project_id: project.id
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end
  end

  context "with permission to view the project" do
    before(:each) do
      sign_in(:user, user)
      Permission.create!(user: user, thing: project, action: "view")
    end

    def cannot_create_tickets!
      expect(response).to redirect_to(project)
      expect(flash[:alert]).to eql("You cannot create tickets on this project.")
    end

    it "cannot begin to create a ticket" do
      get :new, project_id: project.id
      cannot_create_tickets!
    end

    it "cannot create a ticket without permission" do
      post :create, project_id: project.id, ticket: { title: ticket.title, description: ticket.description } 
      cannot_create_tickets!
    end

    def cannot_edit_tickets!
      expect(response).to redirect_to(project)
      expect(flash[:alert]).to eql("You cannot update tickets on this project.")
    end

    it "cannot edit a ticket without permission" do
      get :edit, { project_id: project.id, id: ticket.id }
      cannot_edit_tickets! 
    end

    it "cannot update a ticket without permission" do
      put :update, { project_id: project.id, id: ticket.id, ticket: { title: ticket.title, description: ticket.description } }
      cannot_edit_tickets!
    end
  end
end
