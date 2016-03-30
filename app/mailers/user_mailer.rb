class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invitation.subject
  #

  default from: "invitation@planit.com"
  def invitation(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, subject: "Invitation"
  end
end
