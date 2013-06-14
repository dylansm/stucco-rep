class AddLogoToSchools < ActiveRecord::Migration
  def change
    add_attachment :schools, :school_logo
    add_column :schools, :name, :string
  end
end
