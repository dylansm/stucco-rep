require "spec_helper"

include Warden::Test::Helpers
Warden.test_mode!

describe "Pages Features" do

  describe "home page" do

    before { visit root_path }

    it "has home content" do
      expect(page).to have_content('home')
    end

    it "has the correct page title" do
      expect(page).to have_title("Adobe Rep Portal")
    end

    it "does not have page divider part of tite" do
      expect(page.title).to_not have_content("|")
    end

  end

  context "when unauthenticated user visits home page" do

    before { visit root_path }

    it "has log out link" do
      expect(page).to have_link("Log in")
    end
    
  end

  context "when authenticated user visits home page" do

    # this doesn't work
    #let(:user) {
      #user = FactoryGirl.create(:user)
      #login_as user, scope: :user
    #}
    
    before do
      @user = FactoryGirl.create(:user)
      login_as @user, :scope => :user
      visit root_path
    end

    it "has log out link" do
      expect(page).to have_link("Log out")
    end

    it "has profile link" do
      expect(page).to have_link("Profile")
    end

  end
  
end
