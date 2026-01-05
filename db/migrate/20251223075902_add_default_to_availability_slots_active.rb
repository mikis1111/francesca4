class AddDefaultToAvailabilitySlotsActive < ActiveRecord::Migration[7.1]
  def change
    change_column_default :availability_slots, :active, true
  end
end
