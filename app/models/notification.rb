class Notification < ActiveRecord::Base
  has_one :notifier
  has_many :users, through: :notifier
  validates(:title, presence: true)
  validates(:text, presence: true)
end
