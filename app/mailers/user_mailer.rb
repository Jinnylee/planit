class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invitation.subject
  #

  default from: "invitation@planit.com"
  def invitation(email, secure_hash, current_user)
    @domain_url = ENV["URL"]
    @email = email
    @secure_hash = secure_hash
    @current_user = current_user

    mail to: @email, subject: "Invitation"
  end
end
