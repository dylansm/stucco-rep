class CreateNotificationsUsers < ActiveRecord::Migration
  def change
    create_table :notifications_users do |t|
      t.integer :notification_id
      t.integer :user_id

      t.timestamps
    end
  end
end
