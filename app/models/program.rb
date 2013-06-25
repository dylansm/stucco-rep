class Program < ActiveRecord::Base
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :users

  validates(:name, presence: true)

  #scope :users_not_in, -> do
    #if self.arel_table[:users]
      ##users.where("admin = false AND id NOT IN (?)", users.users.map(&:id))
      ##where("admin = false AND id NOT IN (?)", users.users.map(&:id)).joins(:user)
      #User.where("admin = false AND id NOT IN (?)", users.map(&:id)).joins(:programs)
    #else
      #User.where("admin = false").joins(:programs)
    #end
  #end
  
end
