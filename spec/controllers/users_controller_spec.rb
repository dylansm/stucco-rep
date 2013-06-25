require 'spec_helper'

describe UsersController do

  let(:user) { create :user }
  let(:admin) { create :admin }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    ApplicationController.any_instance.stub(:current_user)
  end

  context "when authenticated" do

    before { sign_in user }

    describe "GET 'show'" do
      before { get :show, id: user.id }

      it "returns http success" do
        expect(response).to be_success
      end

      it "does not fetch Facebook posts if there is no authentication_token" do
        expect(assigns(:facebook_posts)).to be_nil
      end

      describe "GET /profile" do
        it "works when logged in" do
          expect(response.status).to eq(200)
        end
      end

    end
  end

  context "when logged in" do

    before do 
      sign_in user
      UsersController.any_instance.stub(:authentication_token)
    end

    describe "GET /profile" do
      it "works when logged in" do
        get "show"
        expect(response.status).to eq(200)
      end
    end

  end

  context "when not logged in" do
    before { sign_out user }

    describe "GET /profile" do
      it "redirects to home" do
        get "show", user: user
        expect(response.status).to eq(302)
      end
    end
  end

end
