class AdobeProduct < ActiveRecord::Base
  belongs_to :tool
  validates(:name, presence: true)
  default_scope { order("name ASC") }

  has_attached_file :mnemonic, styles: { sm: "16x16" }

end
