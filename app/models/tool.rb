class Tool < ActiveRecord::Base
  belongs_to :user
  belongs_to :adobe_product

  def add_names
    self.name = self.adobe_product.name unless adobe_product_id.nil?
  end
end
