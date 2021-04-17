class ApplicationController < ActionController::Base
  include Pagy::Backend

  respond_to :html, :json, :turbo_stream
  serialization_scope :view_context
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_toast_message, if: -> { params[:notice].present? || params[:alert].present? }
  before_action :assign_themes

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

  def set_modal_url
    @modal_url = if user_signed_in?
      new_modals_snippet_path
    else
      sign_in_sign_up_modals_users_path
    end
  end

  def assign_themes
    @themes = [
      'one-dark',
      '3024-day',
      '3024-night',
      'abcdef',
      'ambiance',
      'ayu-dark',
      'ayu-mirage',
      'base16-dark',
      'base16-light',
      'bespin',
      'blackboard',
      'cobalt',
      'colorforth',
      'darcula',
      'dracula',
      'duotone-dark',
      'duotone-light',
      'eclipse',
      'elegant',
      'erlang-dark',
      'gruvbox-dark',
      'hopscotch',
      'icecoder',
      'idea',
      'isotope',
      'lesser-dark',
      'liquibyte',
      'lucario',
      'material',
      'material-darker',
      'material-palenight',
      'material-ocean',
      'mbo',
      'mdn-like',
      'midnight',
      'monokai',
      'moxer',
      'neat',
      'neo',
      'night',
      'nord',
      'oceanic-next',
      'panda-syntax',
      'paraiso-dark',
      'paraiso-light',
      'pastel-on-dark',
      'railscasts',
      'rubyblue',
      'seti',
      'shadowfox',
      'solarized dark',
      'solarized light',
      'the-matrix',
      'tomorrow-night-bright',
      'tomorrow-night-eighties',
      'ttcn',
      'twilight',
      'vibrant-ink',
      'xq-dark',
      'xq-light',
      'yeti',
      'yonce',
      'zenburn'
    ]
  end
end
