if Rails.env.development?

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'enigmatic-mountain-93417.herokuapp.com/',
  user_name:            ENV["GMAIL_USERNAME"],
  password:             ENV["GMAIL_PASSWORD"],
  authentication:       'plain',
  enable_starttls_auto: true 
}

elsif Rails.env.production?

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'enigmatic-mountain-93417.herokuapp.com',
  user_name:            ENV["GMAIL_USERNAME"],
  password:             ENV["GMAIL_PASSWORD"],
  authentication:       'plain',
  enable_starttls_auto: true 
}

end