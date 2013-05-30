class AddProgramAdminIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :program_admin_id, :integer
  end
end
