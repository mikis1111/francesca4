class AvailabilitySlot < ApplicationRecord
    validates :scheduled_at, presence: true
  
    scope :active, -> { where(active: true) }
    scope :future, -> { where("scheduled_at > ?", Time.current) }
  
    def past?
      scheduled_at <= Time.current
    end
  end
  