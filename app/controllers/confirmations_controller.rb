class ConfirmationsController < Devise::ConfirmationsController
  layout 'basic'

  before_action :set_content

  private

  def set_content
    @header = 'Resend confirmation'
    @sub_header = 'Enter your email below to receive instructions on how to confirm your email address'
    @footer = "#{view_context.link_to('Confirmed your email? Sign in', new_user_session_path)}".html_safe
  end
end
