class CreateProgramsSchools < ActiveRecord::Migration
  def change
    create_table :programs_schools do |t|
      t.integer :program_id
      t.integer :school_id

      t.timestamps
    end
  end
end
