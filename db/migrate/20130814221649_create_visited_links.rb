class CreateVisitedLinks < ActiveRecord::Migration
  def change
    create_table :visited_links do |t|
      t.integer :user_id
      t.integer :link_id
      t.integer :link_count
    end
    add_index(:visited_links, [:user_id, :link_id])
  end
end
