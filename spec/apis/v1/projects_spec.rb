require 'spec_helper'

describe "/api/v1/projects", type: :api do
  let(:user) { create_user! } 
  let(:token) { user.authentication_token }

  before do
    @project = create(:project)
    user.permissions.create(:action => "view", :thing => @project)
  end

  context "projects viewable by this user" do
    let(:url) { "/api/v1/projects" } 
    before(:each) do
      create(:project, name: "Access Denied")
    end
    it "json" do
      get "#{url}.json", :token => token

      projects_json = Project.for(user).all.to_json
      expect(last_response.body).to eql(projects_json)
      expect(last_response.status).to eql(200)
      
      projects = JSON.parse(last_response.body)
      expect(projects.any? do |p|
        p["name"] == "Ticketee"
      end).to eql true      
      expect(projects.any? do |p|
        p["name"] == "Access Denied"
      end).to eql false
    end
  end 
end