class AddFieldsToAdobeProducts < ActiveRecord::Migration
  def change
    add_column :adobe_products, :name, :string
    add_attachment :adobe_products, :mnemonic
  end
end
