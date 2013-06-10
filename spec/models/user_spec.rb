require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }
  let(:admin_user) { FactoryGirl.create :user, :admin }
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
      expect(user.tools.first).to be_an_instance_of(Tool)
    end
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
