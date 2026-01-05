class Admin::AvailabilitySlotsController < ApplicationController
  before_action :require_admin

  def index
    @availability_slots = AvailabilitySlot.order(:scheduled_at)
    @availability_slot  = AvailabilitySlot.new
  
    # 🔑 tutte le prenotazioni indicizzate per scheduled_at
    @bookings_by_time = FreeConsultationBooking
                          .includes(:user)
                          .index_by(&:scheduled_at)
  end
  

  def create
    @availability_slot = AvailabilitySlot.new(availability_slot_params)

    if @availability_slot.save
      redirect_to admin_availability_slots_path,
                  notice: "Slot creato con successo"
    else
      @availability_slots = AvailabilitySlot.order(:scheduled_at)
      flash.now[:alert] = "Errore nella creazione dello slot"
      render :index, status: :unprocessable_entity
    end
  end

  def send_reminder
    slot = AvailabilitySlot.find(params[:id])
  
    booking = FreeConsultationBooking.find_by(scheduled_at: slot.scheduled_at)
  
    if booking
      FreeConsultationMailer.reminder(booking).deliver_later
      redirect_to admin_availability_slots_path,
                  notice: "Email di promemoria inviata correttamente"
    else
      redirect_to admin_availability_slots_path,
                  alert: "Nessuna prenotazione trovata per questo slot"
    end
  end
  



  def toggle
    slot = AvailabilitySlot.find(params[:id])
    slot.update!(active: !slot.active)
    redirect_to admin_availability_slots_path
  end

  def destroy
    AvailabilitySlot.find(params[:id]).destroy
    redirect_to admin_availability_slots_path
  end

  private

  # 🔑 STRONG PARAMS (QUESTO MANCAVA)
  def availability_slot_params
    params.require(:availability_slot).permit(:scheduled_at)
  end
end
