require "spec_helper"

describe "Pages Requests" do

  describe "GET /" do
    it "works as root" do
      get root_path
      expect(response.status).to eq(200)
    end
  end
  
end
