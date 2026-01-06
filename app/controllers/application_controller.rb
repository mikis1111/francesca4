class ApplicationController < ActionController::Base
  helper FreeConsultationsHelper
  helper_method :current_user, :logged_in?, :admin?

  before_action :require_login

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    logged_in? && current_user.admin?
  end

  private

  def require_login
    return if logged_in?
  
    # evita loop infinito sul login
    if controller_name == "sessions" && action_name == "new"
      return
    end
  
    redirect_to login_path, alert: "Devi effettuare l'accesso per continuare."
  end
  

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Accesso non autorizzato"

    end
  end
  
end


  