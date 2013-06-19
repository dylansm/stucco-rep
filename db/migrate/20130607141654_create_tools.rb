class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.integer :user_id
      t.integer :adobe_product_id
      t.string  :name
      t.integer :skill_level

      t.timestamps
    end
  end
end
