class AddIndicesToNotificationsUsers < ActiveRecord::Migration
  def change
    add_index(:notifications_users, [:notification_id, :user_id])
  end
end
