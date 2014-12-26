class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource
  before_filter :configure_permitted_parameters, if: :devise_controller?
  #before_action :set_locale
  #rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_up_path_for(resource)
    root_url # After login, it goes to this
  end


  def after_sign_in_path_for(resource)
    root_url # After register, it goes to this
  end

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
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :name, :email, :password, :password_confirmation, :current_password) }
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
    # if params[:lang] is nil then I18n.default_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  private

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

end
