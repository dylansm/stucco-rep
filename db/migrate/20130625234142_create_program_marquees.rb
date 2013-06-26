class CreateProgramMarquees < ActiveRecord::Migration
  def change
    create_table :program_marquees do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
