class Link < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :programs
  validates_uniqueness_of :name
  validates_uniqueness_of :url
end
