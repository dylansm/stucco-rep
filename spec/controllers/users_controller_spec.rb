require 'spec_helper'

describe UsersController do

  context "when logged in" do

    let(:user) { FactoryGirl.create :user }

    before { sign_in user }

    describe "GET 'show'" do
      it "returns http success" do
        get :show, id: user
        expect(response).to be_success
      end
    end

    context "when logged in as admin" do
      
      let(:admin) { FactoryGirl.create(:user, :admin) }

      describe "GET 'show'" do
        it "returns http success" do
          get :show, id: admin
          expect(response).to be_success
        end
      end

    end
    
  end

  context "when not logged in" do

    let(:user) { FactoryGirl.create :user }
    let(:admin) { FactoryGirl.create :user, :admin }
    
    describe "GET 'show'" do
      it "returns http success" do
        get :show, id: user
        expect(response).to be_redirect
      end
    end

    describe "GET 'show' admins" do
      it "returns http success" do
        get :show, id: admin
        expect(response).to be_redirect
      end
    end
  end
end
