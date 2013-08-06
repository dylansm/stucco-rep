require 'spec_helper'

describe Newsfeed::PostsController do

  let(:user) { create :user }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    ApplicationController.any_instance.stub(:current_user)
  end

  describe "GET 'index'" do
    it "redirects if not logged in" do
      get 'index'
      expect(response).to be_redirect
    end

    describe "when logged in" do

      before do
        sign_in user
        controller.stub(:user).and_return(user)
      end
      
      it "works" do
        get 'index'
        expect(response).to be_success
      end

    end

  end
  
end
