class Program < ActiveRecord::Base
  #has_many :users
  #has_many :program_admins, through: :users
  #has_many :program_admins, :class_name => "User", :foreign_key => "program_admin_id"
  has_many :program_managers
  has_many :users, through: :program_managers
  has_many :users
  has_and_belongs_to_many :schools
  #accepts_nested_attributes_for :users, :program_admins
end
