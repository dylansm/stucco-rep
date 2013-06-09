class CreateUserApplications < ActiveRecord::Migration
  def change
    create_table :user_applications do |t|

      t.timestamps
    end
  end
end
