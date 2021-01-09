class ApplicationController < ActionController::Base
  respond_to :html, :json
  serialization_scope :view_context
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_toast_message, if: -> { params[:notice].present? || params[:alert].present? }
  before_action :assign_users_for_connect, :set_modal_url, unless: -> { devise_controller? }

  UNAUTHORIZED = 'You do not have access to this page'.freeze

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :bio, :location, :password, :current_password, :password_confirmation)}
  end

  private

  def set_toast_message
    flash[:notice] = params[:notice] || params[:alert]
  end

  def assign_users_for_connect
    if user_signed_in?
      @users_for_connect = current_user.not_following.limit(5)
    else
      @users_for_connect = User.order(updated_at: :desc).limit(5)
    end
  end

  def set_modal_url
    @modal_url = if user_signed_in?
      new_modals_snippet_path
    else
      sign_in_sign_up_modals_users_path
    end
  end
end
