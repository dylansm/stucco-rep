class AdobeProduct < ActiveRecord::Base
  validates(:name, presence: true)
  validates(:mnemonic, presence: true)

  has_attached_file :mnemonic, styles: {
    sm: "16x16",
    storage: "s3",
    s3_credentials: {
      access_key_id: API_KEYS['amazon']['api_key'],
      secret_access_key: API_KEYS['amazon']['api_secret'],
      bucket: API_KEYS['amazon']['bucket']
    },
    path: ":attachment/:id/:style/:basename.:extension"
  }
end
