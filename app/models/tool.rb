class Tool < ActiveRecord::Base
  belongs_to :user
  belongs_to :adobe_product
end
