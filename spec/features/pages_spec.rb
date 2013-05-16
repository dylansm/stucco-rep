require "spec_helper"

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
  
end
