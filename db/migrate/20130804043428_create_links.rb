class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :activity_name
      t.string :tag_url
      t.string :tag_id
      t.integer :user_id

      t.timestamps
    end
    add_index :links, :user_id
  end
end
