require 'spec_helper'

describe User do

  let(:user) { create :user }
  let(:admin_user) { create :admin }
  subject { user }

  context "when valid" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:admin) }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }
    it { should respond_to :active_for_authentication }
    
    it { should be_valid }
  end

  context "when a user is created" do
    let(:tool) { create :tool }
    let(:user_with_tools) { create :user_with_tools }

    it "is not an admin" do
      expect(user.admin?).to eq(false)
    end

    it "is active (not suspended)" do
      expect(user.active_for_authentication).to eq(true)
    end

    it "has an associated user_application" do
      expect(user.user_application).to be_an_instance_of(UserApplication)
    end

    it "has associated tools" do
      expect(user_with_tools.tools.count).to eq(7)
    end
    
    it "has tools of correct class type" do
      expect(user_with_tools.tools.first).to be_an_instance_of(Tool)
    end

    it "has user's skill level" do
      expect(user_with_tools.tools.first.skill_level).to eq(5)
    end

    it "has adobe product name" do
      expect(user_with_tools.tools.first.adobe_product.name).to eq("Photoshop")
    end

  end


  context "when a user belongs to a program through program managers" do

    let(:program_with_managers) { create :program_with_managers }
    #let(:program_with_users) { create :program_with_users }

    it "should show program managers for program" do
      expect(program_with_managers.program_managers.count).to eq 2
    end

    #it "should show users for program manager" do
      #expect(program_with_users.users.count).to eq 10
    #end
    
  end


  context "when an admin is created" do
    it "has admin set to true" do
      expect(admin_user.admin?).to eq(true)
    end
  end

  context "when invalid" do
    
    it "is invalid if first name missing" do
      user.first_name = ''
      expect(user).to_not be_valid
    end

    it "is invalid if last name missing" do
      user.last_name = ''
      expect(user).to_not be_valid
    end

  end
end
