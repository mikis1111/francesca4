class CreateFreeConsultationBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :free_consultation_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.string :status

      t.timestamps
    end
  end
end
