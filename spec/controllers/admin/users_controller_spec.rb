require 'spec_helper'

describe Admin::UsersController do
  let(:user) { create_user! }

  context "standard users" do
     before(:each) do
       sign_in(:user, user)
     end

     it "are not able to access the index action" do
       get "index"
       expect(response).to redirect_to(root_path)
       expect(flash[:alert]).to eql("You must be admin to do that.")
     end
   end 

end
