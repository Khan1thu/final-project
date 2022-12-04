class WelcomeMailer < ApplicationMailer
    def welcome_send(user)
        @user = user
        mail to: @user.email, subject: "Welcome to wisp", from: "info@mysite.com"
    end
end