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
    
    it { should be_valid }
  end

  context "when a user is created" do
    it "is not an admin" do
      expect(user.admin?).to eq(false)
    end

    it "is active (not suspended)" do
      expect(user.suspended).to eq(false)
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
