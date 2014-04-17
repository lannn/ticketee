require 'spec_helper'

describe ProjectsController do
  let(:user) { create_user! }
  let(:project) { create(:project) } 

  context "standard users" do
    { "new" => "get", "create" => "post", "edit" => "get", "update" => "put", "destroy" => "delete" }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(:user, user)
        send(method, action.dup, :id => project.id)
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eql("You must be admin to do that.")
      end
    end

    it "cannot access the show action" do
      sign_in(:user, user)
      get :show, :id => project.id
      expect(response).to redirect_to(projects_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.") 
    end
  end

  it "display an error for missing project" do
    sign_in(:user, user)
  	get :show, :id => "not-here"
  	expect(response).to redirect_to(projects_path)
    expect(flash[:alert]).to eql("The project you were looking for could not be found.")
  end

end
