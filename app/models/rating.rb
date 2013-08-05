class Rating < ActiveRecord::Base
  belongs_to :post
  belongs_to :event
end
