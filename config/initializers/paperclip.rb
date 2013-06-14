Paperclip::Attachment.default_options[:storage] = 's3'
Paperclip::Attachment.default_options[:bucket] = API_KEYS['amazon']['bucket']
Paperclip::Attachment.default_options[:s3_credentials] = {
  access_key_id: API_KEYS['amazon']['api_key'],
  secret_access_key: API_KEYS['amazon']['api_secret']
}
Paperclip::Attachment.default_options[:url] = ":s3_domain_url"
Paperclip::Attachment.default_options[:path] = "/:attachment/:id/:style/:basename.:extension"
