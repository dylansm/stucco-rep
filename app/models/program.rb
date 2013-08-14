class Program < ActiveRecord::Base
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :users
  has_and_belongs_to_many :links

  validates(:name, presence: true)
  
end
