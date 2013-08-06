require "spec_helper"

describe "Page requests" do
  #before do
    #ApplicationController.any_instance.stub(:current_user)
  #end

  describe "GET /" do
    it "works as root" do
      get root_path
      expect(response.status).to eq(200)
    end
  end

  describe "GET /admin/users" do
    it "should redirect if not logged in" do
      get '/admin/users'
      expect(response.status).to eq(302)
    end
  end

end
