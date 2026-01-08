class FreeConsultationsController < ApplicationController
  before_action :require_login
  before_action :prevent_multiple_free_bookings, only: [:new, :create]

  

  def new
    @free_consultation_booking = FreeConsultationBooking.new
    @grouped_slots = grouped_availability_slots
  end

  def create
    @free_consultation_booking = FreeConsultationBooking.new(free_consultation_booking_params)
    @free_consultation_booking.user = current_user
  
    # 🔑 LINK ZOOM (OBBLIGATORIO)
    @free_consultation_booking.zoom_link =
      "https://us05web.zoom.us/j/83516339827?pwd=m5JXks6o495zlQWdAAwjsW1kwIHawh.1"
  
    if @free_consultation_booking.save
      # 📧 EMAIL DI CONFERMA (QUESTA MANCAVA)
      FreeConsultationMailer
        .confirmation(@free_consultation_booking)
        .deliver_now
  
      redirect_to root_path,
                  notice: "Consulenza gratuita prenotata con successo!"
    else
      render :new, status: :unprocessable_content
    end
  end
  
  

  private

  def free_consultation_booking_params
    params.require(:free_consultation_booking).permit(:scheduled_at)
  end

  def grouped_availability_slots
    booked_times = FreeConsultationBooking.pluck(:scheduled_at)
  
    AvailabilitySlot
      .where(active: true)
      .where.not(scheduled_at: booked_times)
      .order(:scheduled_at)
      .group_by { |slot| slot.scheduled_at.to_date }
      .map do |date, slots|
        [
          date.strftime("%d/%m/%Y"),
          slots.map do |slot|
            [
              slot.scheduled_at.strftime("%H:%M"),
              slot.scheduled_at
            ]
          end
        ]
      end
  end
  


  def prevent_multiple_free_bookings
    return unless current_user
  
    if FreeConsultationBooking.exists?(scheduled_at: @free_consultation_booking.scheduled_at)
      redirect_to prenota_consulenza_path,
                  alert: "Questo slot non è più disponibile."
      return
    end
    
    if @free_consultation_booking.save
    
    
  end
end
end