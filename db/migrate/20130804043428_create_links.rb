class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.integer :program_id

      t.timestamps
    end

    add_index :links, :program_id
  end
end
