class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource
  before_filter :configure_permitted_parameters, if: :devise_controller?
  #before_action :set_locale

  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
  end

  protected

  def layout_by_resource
    if devise_controller?
      "login/application"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :name, :email, :password, :password_confirmation) }
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
    # if params[:lang] is nil then I18n.default_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
