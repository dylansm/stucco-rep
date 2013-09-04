class AddSocialPlatformToVisitedLinks < ActiveRecord::Migration
  def change
    add_column :visited_links, :social_platform, :string
  end
end
