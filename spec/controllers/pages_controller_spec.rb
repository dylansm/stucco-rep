require 'spec_helper'

describe PagesController do

  before { @program = create :program }

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

end
