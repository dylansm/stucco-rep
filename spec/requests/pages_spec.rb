require "spec_helper"

describe "Page requests" do

  describe "GET /" do
    it "works as root" do
      get root_path
      expect(response.status).to eq(200)
    end
  end
  
  #context "when logged in" do

    #let(:user) { FactoryGirl.create :user }

    #before { sign_in user }

    #describe "GET /profile" do
      #it "works when logged in" do
        #get "/profile"
        #expect(response.status).to eq(200)
      #end
    #end

  #end

end
