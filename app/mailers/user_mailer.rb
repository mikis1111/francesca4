class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user

    mail(
      to: @user.email,
      subject: "Benvenuto nel sito di Francesca Vitale"
    )
  end
end
