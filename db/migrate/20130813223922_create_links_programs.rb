class CreateLinksPrograms < ActiveRecord::Migration
  def change
    create_table :links_programs do |t|
      t.integer :link_id
      t.integer :program_id
    end
    add_index(:links_programs, [:link_id, :program_id])
  end
end
