require 'spec_helper'

describe User do
  it "resets the request count" do
    user = create(:user)
    user.update_attribute(:request_count, 42)
    User.reset_request_count!
    expect(user.reload.request_count).to eql(0)
  end
end
