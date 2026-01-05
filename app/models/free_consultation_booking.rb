class FreeConsultationBooking < ApplicationRecord
  belongs_to :user

  validates :scheduled_at, presence: true
  validates :zoom_link, presence: true
  # 🔒 UNA SOLA CONSULENZA GRATUITA PER UTENTE
  validates :user_id, uniqueness: {
    message: "hai già prenotato una consulenza gratuita"
  }

  def time_status
    today = Date.current

    if scheduled_at.to_date == today
      "oggi"
    elsif scheduled_at.to_date > today
      "futura"
    else
      "passata"
    end
  end
end


  def new
    @free_consultation_booking = FreeConsultationBooking.new
  end

  def create
    @free_consultation_booking = FreeConsultationBooking.new(free_consultation_booking_params)
    @free_consultation_booking.user = current_user if logged_in?

    if @free_consultation_booking.save
      redirect_to root_path, notice: "Consulenza gratuita prenotata con successo"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def free_consultation_booking_params
    params.require(:free_consultation_booking).permit(:scheduled_at)
  end


