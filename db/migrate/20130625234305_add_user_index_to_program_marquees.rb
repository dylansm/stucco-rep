class AddUserIndexToProgramMarquees < ActiveRecord::Migration
  def change
    add_index :program_marquees, :user_id
  end
end
