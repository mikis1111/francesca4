class User < ApplicationRecord
    has_secure_password
    
    has_many :client_notes, dependent: :destroy
    has_many :free_consultation_bookings, dependent: :destroy
    
    
    
    validates :name, presence: true, length: { minimum: 2 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 6 }, allow_nil: true

    def admin?
      self.admin == true
    end

    def full_name
      name.presence || email
    end
    
  end