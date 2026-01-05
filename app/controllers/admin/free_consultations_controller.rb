module Admin
    class FreeConsultationsController < ApplicationController
      before_action :require_admin
  
      def index
        @bookings = FreeConsultationBooking
                      .includes(:user)
                      .order(scheduled_at: :asc)
      
        if params[:query].present?
          q = "%#{params[:query]}%"
          @bookings = @bookings
                        .where("users.name LIKE ? OR users.email LIKE ?", q, q)
                        .references(:users)
        end
      end
      
      def destroy
        booking = FreeConsultationBooking.find(params[:id])
        booking.destroy
        redirect_to admin_free_consultations_path,
                    notice: "Consulenza eliminata correttamente"
      end
      
      def send_reminder
        booking = FreeConsultationBooking.find(params[:id])
      
        FreeConsultationMailer
          .reminder(booking)
          .deliver_now
      
        redirect_to admin_free_consultations_path,
                    notice: "Promemoria inviato a #{booking.user.email}"
      end
      
      
      
  
      private
  
      def require_admin
        redirect_to root_path, alert: "Accesso non autorizzato" unless current_user&.admin?
      end
    end
  end
  