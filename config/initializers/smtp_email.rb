ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => "587",
  :domain => "gmail.com",
  :user_name => "nhannv.nustechnology@gmail.com",
  :password => "123456789!@#$%",
  :authentication => "login",
  :enable_starttls_auto => true
}
