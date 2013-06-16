require "spec_helper"

describe "Page requests" do

  describe "GET /" do
    it "works as root" do
      get root_path
      expect(response.status).to eq(200)
    end
  end

  describe "GET /dashboard/admin/users" do
    it "should redirect if not logged in" do
      get '/dashboard/admin/users'
      expect(response.status).to eq(302)
    end
  end

end
