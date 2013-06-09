require "spec_helper"

include Warden::Test::Helpers
Warden.test_mode!

describe "Pages Features" do

  describe "home page" do

    let(:user) { FactoryGirl.create(:user) }

    before do
      logout(user)
      visit root_path
    end

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

    describe "home page" do

      it "has dashboard content" do
        expect(page).to have_content('Dashboard')
      end

      it "does not have admin tools" do
        expect(page).to_not have_content('Admin Tools')
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

    end
    
    describe "profile page" do
      before { visit user_path(@user) }
        
      it "has page separator in title" do
        expect(page.title).to have_content("My Profile |")
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

      it "has admin tools" do
        expect(page).to have_content('Admin Tools')
      end

      it "has admin page title" do
        expect(page.title).to have_content("Admin Dashboard |")
      end

    end

  end

  context "when editing profile" do
    before do
      @user = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:user, :admin)
      login_as @admin, :scope => :user
      visit edit_user_path(@user)
    end

    describe "other user's profile" do
      it "has page title" do
        expect(page.title).to have_content("Edit #{@user.first_name} #{@user.last_name}’s Account |")
      end
    end

    describe "user's own profile" do
      before { visit edit_user_path(@admin) }
      
      it "has page title" do
        expect(page.title).to have_content("Edit Your Account |")
      end
    end
  end


  context "when users visit profile" do
    
    before do
      @user = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:user, :admin)
      login_as @user, :scope => :user
    end

    describe "their own page" do
      before { visit user_path(@user) }
      it "has the title" do
        expect(page.title).to have_content("My Profile")
      end
    end

    describe "another user's page" do
      before { visit user_path(@admin) }
      it "has the title" do
        expect(page.title).to have_content("#{@admin.first_name} #{@admin.last_name}")
      end
    end
  end

    
end
