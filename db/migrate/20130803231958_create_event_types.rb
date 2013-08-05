class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name
      t.integer :event_id
      t.integer :points

      t.timestamps
    end
  end
end
