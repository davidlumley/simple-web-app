if ENV['RACK_ENV'] == 'production'
  Pony.options = {
    :from        => 'noreply@example.com',
    :via         => :smtp,
    :via_options => {
      :address              => 'smtp.sendgrid.net',
      :port                 => '587',
      :domain               => 'heroku.com',
      :user_name            => ENV['SENDGRID_USERNAME'],
      :password             => ENV['SENDGRID_PASSWORD'],
      :authentication       => :plain,
      :enable_starttls_auto => true,
    }
  }
else
  # SendMail
  #Pony.options = {
  #  :from        => 'noreply@example.com',
  #  :via         => :sendmail,
  #}

  # MockSMTP
  Pony.options = {
    :via         => :smtp,
    :from        => 'noreply@example.com',
    :via_options => {
      :address        => 'localhost',
      :port           => '1025',
      :authentication => :login,
    }
  }
end