module Admin::ClientsHelper
    def format_schedule(datetime)
      datetime.strftime("%d %b %Y alle %H:%M")
    end
  end
  