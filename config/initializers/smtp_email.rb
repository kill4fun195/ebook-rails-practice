if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
else
  ActionMailer::Base.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => "587",
   :domain => "gmail.com",
   :user_name => "nhannv.nustechnology@gmail.com",
   :password => "123456789!@#$%",
   :authentication => "login",
   :enable_starttls_auto => true
  }
end
