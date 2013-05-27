require 'spec_helper'

describe UsersController do

  context "when authenticated" do

    let(:user) { FactoryGirl.create :user }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET 'show'" do
      it "returns http success" do
        get :show, id: user.id
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

    before { @request.env["devise.mapping"] = Devise.mappings[:user] }
    
    describe "GET users#show" do
      it "redirects when unauthenticated" do
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
