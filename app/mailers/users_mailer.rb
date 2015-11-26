class UsersMailer < ApplicationMailer

  def notify_new_user(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to dblog ")
  end
end
