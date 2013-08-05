class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :text
      t.integer :user_id
      t.integer :program_manager_id

      t.timestamps
    end
  end
end
