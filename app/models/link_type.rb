class LinkType < ActiveRecord::Base
  has_and_belongs_to_many :links
  validates(:name, presence: true)
  validates_uniqueness_of :name
  validates(:call_to_action, presence: true)

  default_scope { order("name ASC") }

  before_destroy do
    LinkTypesLinks.where("link_type_id = ?", id).each do |join|
      link = Link.find(join.link_id)
      link.destroy
    end
  end
end
