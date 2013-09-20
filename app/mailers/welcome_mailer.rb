class WelcomeMailer < ActionMailer::Base
  default from: "nagasundaram@neevtech.com"

  def welcome_email(user)
    @user = user
    @url  = "localhost:3000"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
