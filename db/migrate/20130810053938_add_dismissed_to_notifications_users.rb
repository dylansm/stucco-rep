class AddDismissedToNotificationsUsers < ActiveRecord::Migration
  def change
    add_column :notifications_users, :dismissed, :boolean, default: false
  end
end
