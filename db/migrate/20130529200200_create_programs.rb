class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.attachment :program_icon
      t.string :theme_name
      t.integer :user_id

      t.timestamps
    end
  end
end
