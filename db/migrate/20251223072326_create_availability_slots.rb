class CreateAvailabilitySlots < ActiveRecord::Migration[7.1]
  def change
    create_table :availability_slots do |t|
      t.datetime :scheduled_at
      t.boolean :active

      t.timestamps
    end
  end
end
