class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_id, :integer
    add_column :users, :points, :integer
    add_attachment :users, :avatar
  end
end
