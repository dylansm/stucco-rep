class LinkType < ActiveRecord::Base
  has_and_belongs_to_many :links
  #belongs_to :links
  validates(:name, presence: true)
  validates_uniqueness_of :name

  default_scope { order("name ASC") }
end
