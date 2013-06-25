class UserApplication < ActiveRecord::Base
  belongs_to :user
  has_attached_file :resume
  validates_attachment_content_type :resume, :content_type => [
    'application/msword', 
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 
    'application/pdf',
    'application/rtf', 
    'application/x-rtf', 
    'text/rtf', 
    'text/richtext', 
    'text/plain'
  ]
end
