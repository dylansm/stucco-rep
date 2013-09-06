class Link < ActiveRecord::Base
  belongs_to :user
  #has_many :visited_links, through: :users
  has_many :visited_links
  has_and_belongs_to_many :link_types

  validates_uniqueness_of :tag_identifier
  validates_uniqueness_of :tag_url
  validates(:tag_identifier, presence: true)
  validates(:tag_url, presence: true)
  validates(:user_id, presence: true)
end
