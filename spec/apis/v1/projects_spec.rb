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

    it "XML" do
      get "#{url}.xml", :token => token
      expect(last_response.body).to eql(Project.readable_by(user).to_xml)
      projects = Nokogiri::XML(last_response.body)
      expect(projects.css("project name").text).to eql ("Ticketee")
    end
  end

  context "creating a project" do
    let(:url) { "/api/v1/projects" }
    before do
      user.admin = true
      user.save
    end

    it "successful JSON" do
      post "#{url}.json", token: token, project: { name: "Inspector" }

      project = Project.find_by_name("Inspector")
      route = "/api/v1/projects/#{project.id}"
      expect(last_response.status).to eql(201)
      expect(last_response.headers["Location"]).to eql(route)
      expect(last_response.body).to eql(project.to_json)
    end

    it "unsuccessful JSON" do
      post "#{url}.json", token: token, project: { name: "" }

      expect(last_response.status).to eql(422)
      errors = { "errors" => { "name" => ["can't be blank"]} }.to_json
      expect(last_response.body).to eql(errors)
    end 
  end 

  context "show" do
    let(:url) { "/api/v1/projects/#{@project.id}" } 

    before(:each) do
      create(:ticket, project: @project)
    end

    it "JSON" do
      get "#{url}.json", token: token

      project = @project.to_json(methods: "last_ticket")
      expect(last_response.body).to eql(project)
      expect(last_response.status).to eql(200)

      project_response = JSON.parse(last_response.body)
      ticket_title = project_response["last_ticket"]["title"]
      expect(ticket_title).to be_true
    end
  end

  context "updating a project" do
    let(:url) { "/api/v1/projects/#{@project.id}" }
    before(:each) do
      user.admin = true
      user.save
    end

    it "succeessful JSON" do
      expect(@project.name).to eql("Ticketee")
      put "#{url}.json", token: token, project: { name: "Not Ticketee" }

      expect(@project.reload.name).to eql("Not Ticketee")
      expect(last_response.body).to eql("")
      expect(last_response.status).to eql(204)
    end

    it "unsuccessful JSON" do
      expect(@project.name).to eql("Ticketee")
      put "#{url}.json", token: token, project: { name: "" }

      expect(@project.reload.name).to eql("Ticketee")
      errors = { errors: { name: ["can't be blank"] } }
      expect(last_response.body).to eql(errors.to_json)
      expect(last_response.status).to eql(422)
    end
  end
end