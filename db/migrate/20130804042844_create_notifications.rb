class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :text
      t.boolean :archived

      t.timestamps
    end
  end
end
