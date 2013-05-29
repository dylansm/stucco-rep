require 'spec_helper'

#include Warden::Test::Helpers
#Warden.test_mode!

describe "dashboard/admin/users/new.html.haml" do

  let(:user) { FactoryGirl.create :user }

  context "when authenticated" do

    #before do
      #login_as user, :scope => :user
    #end

    it "renders view" do
      render
      expect(view).to render_template("dashboard/admin/users/new")
    end
    
  end

end
