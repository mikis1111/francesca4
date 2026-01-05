module FreeConsultationsHelper

    def available_slots
      slots = []
  

      def formatted_slots
        available_slots.map do |datetime|
          label = datetime.strftime("%A %d/%m · %H:%M")
      
          if datetime.to_date == Date.today
            label = "⭐ Oggi · #{datetime.strftime('%H:%M')}"
          end
      
          [label, datetime]
        end
      end

      def grouped_slots
        grouped = {
          "Martedì" => [],
          "Giovedì" => []
        }
      
        available_slots.each do |datetime|
          day_name = datetime.wday == 2 ? "Martedì" : "Giovedì"
          label = datetime.strftime("%d/%m · %H:%M")
      
          label = "⭐ Oggi · #{datetime.strftime('%H:%M')}" if datetime.to_date == Date.today
      
          grouped[day_name] << [label, datetime]
        end
      
        grouped
      end
      



      days = {
        2 => (10..11), # Martedì 10:00–12:00
        4 => (15..16)  # Giovedì 15:00–17:00
      }
  
      (Date.today..Date.today + 14).each do |date|
        next unless days.key?(date.wday)
  
        days[date.wday].each do |hour|
          [0, 30].each do |minute|
            datetime = DateTime.new(
              date.year,
              date.month,
              date.day,
              hour,
              minute,
              0
            )
  
            # Escludi slot già prenotati
            unless FreeConsultationBooking.exists?(scheduled_at: datetime)
              slots << datetime
            end
          end
        end
      end
  
      slots.sort
    end
  
    # 🔒 Serve per UX quando non ci sono slot
    def slots_available?
      available_slots.any?
    end
  
  end
  