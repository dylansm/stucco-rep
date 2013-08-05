class Event < ActiveRecord::Base
  has_one :event_type
  has_one :rating, dependent: :destroy
end
