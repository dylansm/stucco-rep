require 'spec_helper'

describe Dashboard::Admin::UsersController do

  let(:user) { create :user }
  let(:admin) { create(:admin) }

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  context "as admin" do

    before { sign_in admin }

    describe "POST #create" do
      it "should create a user" do
        expect { post :create, user: {first_name:"Test2", last_name:"Test2", email: "test2@user.com"} }.to change(User, :count).by 1
      end
    end

    describe "DELETE #destroy" do
      it "deletes user" do
        new_user = create(:user)
        expect { delete :destroy, id: new_user }.to change(User, :count).by -1
      end
    end

  end

  context "when not logged in" do
    before { sign_out user }

    it "does not allow deletion of user" do
      expect { delete :destroy, id: user.id }.to_not change(User, :count)
    end
    
  end

end
