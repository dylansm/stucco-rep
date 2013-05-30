class Program < ActiveRecord::Base
  has_many :users
  has_many :program_admins, :through => :users
end
