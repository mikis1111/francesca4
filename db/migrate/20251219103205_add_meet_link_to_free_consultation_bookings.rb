class AddMeetLinkToFreeConsultationBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :free_consultation_bookings, :meet_link, :string
  end
end
