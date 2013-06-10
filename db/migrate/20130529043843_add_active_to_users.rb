class AddActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_for_authentication, :boolean, default: true
  end
end
