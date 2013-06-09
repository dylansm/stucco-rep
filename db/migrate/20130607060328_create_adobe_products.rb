class CreateAdobeProducts < ActiveRecord::Migration
  def change
    create_table :adobe_products do |t|

      t.timestamps
    end
  end
end
