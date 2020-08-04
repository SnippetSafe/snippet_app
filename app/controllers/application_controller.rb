class ApplicationController < ActionController::Base
  respond_to :html, :json
  serialization_scope :view_context
  before_action :configure_permitted_parameters, if: :devise_controller?

  UNAUTHORIZED = 'You do not have access this page'.freeze

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :bio, :location, :password, :current_password)}
  end
end
