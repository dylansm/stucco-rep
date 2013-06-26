class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :video_id
      t.string :video_provider

      t.timestamps
    end
  end
end
