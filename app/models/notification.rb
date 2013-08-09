class Notification < ActiveRecord::Base
  #belongs_to :user, class_name: "Notifier", foreign_key: "notifier_id"
  belongs_to :notifier, class_name: "User", foreign_key: "notifier_id"
  has_and_belongs_to_many :users
  validates(:title, presence: true)
  validates(:text, presence: true)
  validate :presence_of_recipients
  default_scope { order("created_at DESC") }
  
  def presence_of_recipients
    if self.users.length < 1
      errors.add(:users, "must add at least one recipient")
    end
  end
  
end
