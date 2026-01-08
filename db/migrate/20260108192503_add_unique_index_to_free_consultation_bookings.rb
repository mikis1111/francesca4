class AddUniqueIndexToFreeConsultationBookings < ActiveRecord::Migration[7.1]
  def change
    add_index :free_consultation_bookings,
              :scheduled_at,
              unique: true
  end
  
end
