class NotificationMailer < ApplicationMailer
  def notification_email(user, question)
    @user = user
    @question = question
    mail(to: @user.email, subject: 'You have new notification!')
  end
end
