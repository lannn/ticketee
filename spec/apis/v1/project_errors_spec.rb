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

    it "cannot view projects they do not have access to" do
      project = create(:project)

      get "/api/v1/projects/#{project.id}.json", token: user.authentication_token
      error = { error: "The project you were looking for could not be found." }
      expect(last_response.body).to eql(error.to_json)
      expect(last_response.status).to eql(404)
    end
  end
end