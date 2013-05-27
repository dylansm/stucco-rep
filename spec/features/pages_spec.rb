require "spec_helper"

include Warden::Test::Helpers
Warden.test_mode!

describe "Pages Features" do

  describe "home page" do

    before { visit root_path }

    it "has home content" do
      expect(page).to have_content('Welcome to the Adobe Rep Portal')
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

    it "has login link" do
      expect(page).to have_link("Log in")
    end
    
  end

  context "when authenticated" do
    
    before do
      @user = FactoryGirl.create(:user)
      login_as @user, :scope => :user
      visit root_path
    end

    describe "user visits home page" do

      it "has dashboard content" do
        expect(page).to have_content('Dashboard')
      end

      it "has username in title" do
        expect(page.title).to have_content("#{@user.first_name} #{@user.last_name} |")
      end

      it "has log out link" do
        expect(page).to have_link("Log out")
      end

      it "has profile link" do
        expect(page).to have_link("Profile")
      end

      describe "user visits their profile page" do
        before { visit user_path }
        
        it "has page separator in title" do
          expect(page.title).to have_content("My Profile |")
        end
      end

      describe "user visits their profile page" do
        before { visit edit_user_path(@user) }
        
        it "has page separator in title" do
          expect(page.title).to have_content("Edit Example User’s Account |")
        end
      end

    end


    describe "admin visits home page" do

      before do
        @admin = FactoryGirl.create(:user, :admin)
        login_as @admin, :scope => :user
        visit root_path
      end

      it "has admin dashboard content" do
        expect(page).to have_content('Dashboard')
      end

      it "has admin page title" do
        expect(page.title).to have_content("Admin Dashboard |")
      end

    end

  end


  context "when authenticated user visits home page" do
    
    before do
      @user = FactoryGirl.create(:user)
      login_as @user, :scope => :user
      visit "/users/#{@user.id}"
    end

    describe "user profile page" do
      it "has the user's name in the title" do
        expect(page.title).to have_content("#{@user.first_name} #{@user.last_name}")
      end
    end
  end

    
end
