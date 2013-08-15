class Link < ActiveRecord::Base
  #has_and_belongs_to_many :users
  has_one :user
  has_many :visited_links, through: :user
  has_and_belongs_to_many :programs
  accepts_nested_attributes_for :user
  validates_uniqueness_of :tag_id
  validates_uniqueness_of :tag_url
  validates(:activity_name, presence: true)
  validates(:tag_id, presence: true)
  validates(:tag_url, presence: true)
  validates(:user_id, presence: true)
end
