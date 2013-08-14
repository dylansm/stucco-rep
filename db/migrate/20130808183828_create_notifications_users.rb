class CreateNotificationsUsers < ActiveRecord::Migration
  def change
    create_table :notifications_users do |t|
      t.integer :notification_id
      t.integer :user_id
      t.boolean :dismissed, default: false
    end
  end
end
