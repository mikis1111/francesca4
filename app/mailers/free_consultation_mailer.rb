class FreeConsultationMailer < ApplicationMailer

  # 📧 Email di conferma prenotazione
  def confirmation(booking)
    @booking = booking

    mail(
      to: @booking.user.email,
      subject: "Conferma consulenza gratuita online"
    )
  end

  # ⏰ Email di promemoria (ADMIN)
  def reminder(booking)
    @booking = booking

    mail(
      to: @booking.user.email,
      subject: "Promemoria consulenza gratuita online"
    )
  end

end
