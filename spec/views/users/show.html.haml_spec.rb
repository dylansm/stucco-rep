require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!


describe "users/show.html.haml" do

  let(:user) { FactoryGirl.create :user }

  context "when authenticated" do

    before do
      login_as user, :scope => :user
    end

    it "renders view" do
      assign(:user, user)
      render
      expect(view).to render_template("users/show")
    end
    
  end

end
