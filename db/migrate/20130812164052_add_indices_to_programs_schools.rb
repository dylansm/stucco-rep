class AddIndicesToProgramsSchools < ActiveRecord::Migration
  def change
    add_index(:programs_schools, [:program_id, :school_id])
  end
end
