require 'spec_helper'

describe "dashboard/admin/users/new.html.haml" do

  context "when authenticated" do

    it "renders view" do
      @user = User.new
      render
      expect(view).to render_template("dashboard/admin/users/new")
    end
    
  end

end
