require "spec_helper"

describe "Page requests" do

  describe "GET /" do
    it "works as root" do
      get root_path
      expect(response.status).to eq(200)
    end
  end

  describe "GET /manage-users" do
    it "works as root" do
      get '/manage-users'
      expect(response.status).to eq(302)
    end
  end

end
