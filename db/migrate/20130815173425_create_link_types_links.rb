class CreateLinkTypesLinks < ActiveRecord::Migration
  def change
    create_table :link_types_links do |t|
      t.integer :link_id
      t.integer :link_type_id
    end
    add_index(:link_types_links, [:link_id, :link_type_id])
  end
end
