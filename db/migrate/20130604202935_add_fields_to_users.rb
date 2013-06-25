class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_id, :integer
    add_column :users, :mobile_phone, :string
    add_column :users, :points, :integer
    add_column :users, :current_program_id, :integer
    add_attachment :users, :avatar
    add_index :users, :school_id
    add_index :users, :current_program_id
  end
end
