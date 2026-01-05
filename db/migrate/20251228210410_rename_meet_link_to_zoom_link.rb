class RenameMeetLinkToZoomLink < ActiveRecord::Migration[7.1]
  def change
    rename_column :free_consultation_bookings, :meet_link, :zoom_link
  end
end
