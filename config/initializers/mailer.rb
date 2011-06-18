ActionMailer::Base.default :from => CFG['email-contact']
ActionMailer::Base.layout 'application_mailer'
ActionMailer::Base.smtp_settings = {
  :address              => CFG['mail']['address'],
  :port                 => CFG['mail']['port'],
  :domain               => CFG['domain'],
  :user_name            => CFG['mail']['user_name'],
  :password             => CFG['mail']['password'],
  :authentication       => CFG['mail']['authentication'],
  :enable_starttls_auto => CFG['mail']['enable_starttls_auto']
}

ActionMailer::Base.default_url_options={:host=>CFG['domain']}
Mail.register_interceptor(MailInterceptor) if CFG['mail_intercept']

