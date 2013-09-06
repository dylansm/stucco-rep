class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :tag_url
      t.string :tag_identifier
      t.integer :user_id
      t.integer :visited_links_count, default: 0

      t.timestamps
    end
    add_index :links, :user_id
  end
end
