require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"
require "securerandom"

class GoogleMeetService
  APPLICATION_NAME = "Studio Vitale".freeze
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR
  TOKEN_PATH = "config/google_token.yaml".freeze
  HOST_EMAIL = "supporto@vitalefrancesca.com".freeze

  # === USATO IN PRODUZIONE / AUTOMATICO ===
  def self.authorize
    client_id = Google::Auth::ClientId.new(
      ENV["GOOGLE_CLIENT_ID"],
      ENV["GOOGLE_CLIENT_SECRET"]
    )

    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)

    credentials = authorizer.get_credentials(HOST_EMAIL)

    raise "Google non è autorizzato. Esegui GoogleMeetService.bootstrap! una sola volta." if credentials.nil?

    credentials
  end

  # === USATO UNA SOLA VOLTA, A MANO ===
  def self.bootstrap!
    FileUtils.mkdir_p(File.dirname(TOKEN_PATH))

    client_id = Google::Auth::ClientId.new(
      ENV["GOOGLE_CLIENT_ID"],
      ENV["GOOGLE_CLIENT_SECRET"]
    )

    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)

    url = authorizer.get_authorization_url(
      base_url: "http://localhost:3000/oauth2callback"
    )

    puts "\n🔐 Apri questo URL nel browser (MEGLIO INCOGNITO):"
    puts url
    puts "\n👉 Incolla qui il codice Google:"
    code = STDIN.gets.chomp

    authorizer.get_and_store_credentials_from_code(
      user_id: HOST_EMAIL,
      code: code,
      base_url: "http://localhost:3000/oauth2callback"
    )

    puts "\n✅ Google autorizzato correttamente per #{HOST_EMAIL}"
  end

  # === CREAZIONE EVENTO + GOOGLE MEET ===
  def self.create_meet_event(booking)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    event = Google::Apis::CalendarV3::Event.new(
      summary: "Consulenza nutrizionale online",
      description: "Consulenza online – Studio Vitale",

      # 🔑 ORGANIZZATORE ESPLICITO (HOST)
      organizer: {
        email: HOST_EMAIL
      },

      # 🔑 HOST INVITATO (EVITA BUG GUEST)
      attendees: [
        { email: HOST_EMAIL }
      ],

      start: {
        date_time: booking.scheduled_at.iso8601,
        time_zone: "Europe/Rome"
      },
      end: {
        date_time: (booking.scheduled_at + 30.minutes).iso8601,
        time_zone: "Europe/Rome"
      },

      conference_data: {
        create_request: {
          request_id: SecureRandom.uuid
        }
      }
    )

    created_event = service.insert_event(
      "primary",
      event,
      conference_data_version: 1
    )

    created_event
      .conference_data
      .entry_points
      .find { |e| e.entry_point_type == "video" }
      &.uri
  end
end
