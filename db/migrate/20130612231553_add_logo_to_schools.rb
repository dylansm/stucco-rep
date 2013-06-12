class AddLogoToSchools < ActiveRecord::Migration
  def change
    add_attachment :schools, :logo
  end
end
