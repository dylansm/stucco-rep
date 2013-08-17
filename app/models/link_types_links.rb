class LinkTypesLinks < ActiveRecord::Base
  belongs_to :link
  belongs_to :link_type
end
