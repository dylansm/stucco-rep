ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => API_KEYS['amazon']['api_key'],
  :secret_access_key => API_KEYS['amazon']['api_secret']
