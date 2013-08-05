class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :post_id
      t.integer :event_id

      t.timestamps
    end
  end
end
