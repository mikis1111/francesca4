class ApplicationMailer < ActionMailer::Base
  default from: "Francesca Vitale <support@m.vitalefrancesca.com>"
  default reply_to: "support@m.vitalefrancesca.com"

  before_action :add_list_unsubscribe

  private

  def add_list_unsubscribe
    headers["List-Unsubscribe"] =
      "<mailto:support@m.vitalefrancesca.com>"
  end
end
