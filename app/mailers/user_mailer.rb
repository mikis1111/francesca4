class UserMailer < ApplicationMailer
    def welcome(user)
      @user = user
  
      mail(
        to: @user.email,
        subject: "Benvenuto su Francesca Vitale – Conferma registrazione"
      )
    end
  end
  