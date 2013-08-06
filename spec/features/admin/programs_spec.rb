require "spec_helper"

describe "Programs" do
  context "when at program-users page" do
    describe "body should have data-id attribute" do
      before do
        @program = create :program 
        ApplicationController.any_instance.stub(:current_user)
        ApplicationController.any_instance.stub(:attributes).and_return(@attributes = { :"data-program-id" => "1" })
      end

      it "has program id" do
        #puts "<<<<<#{@attributes}>>>>>"
        visit admin_program_users_path(@program)
        #expect(page.body).to have_xpath('//body[@data-program-id="1"]')
        #expect(page).to have_xpath('//body[@data-program-id="1"]')
        #expect(page).to have_css "body[data-program-id]"
        find("body")['data-program-id']
      end
    end
    
  end
end
