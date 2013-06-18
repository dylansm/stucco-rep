class Program < ActiveRecord::Base
  has_many :program_managers, dependent: :destroy
  has_many :users, through: :program_managers
  has_many :users
  has_and_belongs_to_many :schools
end
