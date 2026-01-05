class NutritionistNote < ApplicationRecord
    self.table_name = "client_notes"
  
    belongs_to :user
  
    validates :content, presence: true
  end
  