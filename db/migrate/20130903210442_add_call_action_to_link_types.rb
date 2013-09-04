class AddCallActionToLinkTypes < ActiveRecord::Migration
  def change
    add_column :link_types, :call_to_action, :string
  end
end
