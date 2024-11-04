class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before_action :require_login
  private
  def require_login
    unless session[:current_username]
      redirect_to login_path, alert: "Log in to access this page"
    end
  end
end
