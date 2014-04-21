require "spec_helper"

describe "Project API errors", :type => :api do
  context "standard users" do
    let(:user) { create_user! } 

    it "cannot create a project" do
      post "/api/v1/projects.json", token: user.authentication_token, project: { name: "Ticketee" }
      
      error = { error: "You must be admin to do that." }
      expect(last_response.body).to eql(error.to_json)
      expect(last_response.status).to eql(401)
      expect(Project.find_by_name("Ticketee")).to eql nil
    end
  end
end