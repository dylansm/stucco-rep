require 'spec_helper'

describe UsersController do

  let(:user) { create :user }
  let(:admin) { create(:admin) }

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

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

  #context "as admin" do

    #before { sign_in admin }

    #describe "GET 'show'" do
      #it "returns http success" do
        #get :show, id: admin
        #expect(response).to be_success
      #end
    #end

    #describe "POST #create" do
      #it "should create a user" do
        #expect { post :create, user: {first_name:"Test2", last_name:"Test2", email: "test2@user.com"} }.to change(User, :count).by 1
      #end
    #end

    #describe "DELETE #destroy" do
      #it "deletes user" do
        #new_user = create(:user)
        #expect { delete :destroy, id: new_user }.to change(User, :count).by -1
      #end
    #end

  #end


  #context "when not logged in" do

    #before do
      #sign_out :user
      #sign_out :admin
    #end
    
    #describe "GET users#show" do
      #it "redirects user when unauthenticated" do
        #get :show, id: user
        #expect(response).to be_redirect
      #end
    #end

    #describe "GET 'show' admins" do
      #it "redirects admin when unauthenticated" do
        #get :show, id: admin
        #expect(response).to be_redirect
      #end
    #end
  #end

  #context "when there is a Facebook authentication_token present" do

    #let(:fb_user) { create :user, :facebook }
    #let(:facebook_stream) { File.read(File.join('spec', 'fixtures', 'facebook_stream.json')) }

    #before do
      #sign_in fb_user
      #controller.stub(:fetch_facebook_stream).and_return(facebook_stream)
    #end

    #describe "GET users#show" do
      #it "fetches Facebook posts" do
        #get :show, id: fb_user
        #expect(assigns[:facebook_posts]).to eq(facebook_stream)
      #end
    #end

  #end

  context "when logged in" do

    before { sign_in user }

    describe "GET /profile" do
      it "works when logged in" do
        get "show"
        expect(response.status).to eq(200)
      end
    end

    describe "GET /profile" do
      it "works when logged in" do
        get "show"
        expect(assigns[:user]).to eq(user)
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
