class RemoveProgramAdminsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :program_admin_id, :integer
  end
end
