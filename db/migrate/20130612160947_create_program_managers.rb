class CreateProgramManagers < ActiveRecord::Migration
  def change
    create_table :program_managers do |t|
      t.integer :user_id
      t.integer :program_id

      t.timestamps
    end
  end
end
