class CreateLinkTypes < ActiveRecord::Migration
  def change
    create_table :link_types do |t|
      #t.integer :link_id
      t.string :name

      t.timestamps
    end
    #add_index :link_types, :link_id
  end
end
