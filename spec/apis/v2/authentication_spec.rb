require 'spec_helper'

describe "API errors", :type => :api do
  it "making request with no token" do
    get "/api/v2/projects.json", :token => ""
    error = { :error => "Token is invalid." }
    expect(last_response.body).to eql(error.to_json)
  end
end