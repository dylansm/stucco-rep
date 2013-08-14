class CreateLinksUsers < ActiveRecord::Migration
  def change
    create_table :links_users do |t|
      t.integer :link_id
      t.integer :user_id
    end
    add_index(:links_users, [:link_id, :user_id])
  end
end
