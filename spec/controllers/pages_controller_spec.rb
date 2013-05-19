require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  context "when logged in" do
    let(:user) { FactoryGirl.create :user }
    let(:admin) { FactoryGirl.create :user, :admin }

    before { sign_in user }

    describe "GET /profile" do
      it "works when logged in" do
        get "user"
        expect(response.status).to eq(200)
      end
    end

    #subject { @user }

    #it "should log in" do
      #sign_in @user
      #sign_in @admin
    #end

    # others?

  end

  context "when not logged in" do

    describe "GET /profile" do
      it "redirects to home" do
        get "user"
        expect(response.status).to eq(302)
      end
    end

    #describe "GET /users"
    
  end
end
