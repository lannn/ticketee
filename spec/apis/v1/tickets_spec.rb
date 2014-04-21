require "spec_helper"

describe "/api/v1/tickets", type: :api do
  let(:project) { create(:project, name: "Ticketee") }

  before do
    @user = create_user!
    @user.update_attribute(:admin, true)
    @user.permissions.create!(action: "view", thing: project)
  end 

  let(:token) { @user.authentication_token } 

  context "index" do
    let(:url) { "/api/v1/projects/#{project.id}/tickets" } 
    before do
      5.times do
        create(:ticket, project: project, user: @user)
      end
    end

    it "XML" do
      get "#{url}.xml", token: token
      expect(last_response.body).to eql(project.tickets.to_xml) 
    end

    it "JSON" do
      get "#{url}.json", token: token
      expect(last_response.body).to eql(project.tickets.to_json) 
    end
  end
end