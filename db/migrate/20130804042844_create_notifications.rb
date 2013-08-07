class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :text
      t.integer :user_id
      t.integer :notifier_id
      t.boolean :dismissed

      t.timestamps
    end
  end
end
