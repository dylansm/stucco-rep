class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_id, :integer
    add_column :users, :program_id, :integer
    add_column :users, :points, :integer
    add_attachment :users, :avatar
    add_index :users, :school_id
    add_index :users, :program_id
  end
end
