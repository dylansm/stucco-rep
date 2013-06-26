class AddMarqueeToProgramMarquees < ActiveRecord::Migration
  def change
    add_attachment :program_marquees, :marquee
  end
end
