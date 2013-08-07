class Notification < ActiveRecord::Base
  has_many :users
  belongs_to :notifier, class_name: "User", foreign_key: "notifier_id"
  validates(:title, presence: true)
  validates(:text, presence: true)
  
end
