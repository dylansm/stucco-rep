class Program < ActiveRecord::Base
  has_many :users
  has_many :program_admins, :class_name => "User", :foreign_key => "program_admin_id"
  accepts_nested_attributes_for :users, :program_admins
end
