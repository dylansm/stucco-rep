class Notification < ActiveRecord::Base
  belongs_to :notifiers, class_name: "User", foreign_key: "notifier_id"
end
