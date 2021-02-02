class PasswordsController < Devise::PasswordsController
  layout 'modal_fake'

  def new
    @header = 'Forgot your password?'
    @sub_header = "Enter your email below and we'll send you instructions on how to reset your password"
    @footer = "#{view_context.link_to('Know your password? Sign in', new_user_session_path)}".html_safe

    super
  end

  def create
    @header = 'Forgot your password?'
    @sub_header = "Enter your email below and we'll send you instructions on how to reset your password"
    @footer = "#{view_context.link_to('Know your password? Sign in', new_user_session_path)}".html_safe

    super
  end

  def edit
    @header = 'Change your password'
    @sub_header = 'Please enter and confirm your new password'

    super
  end
end
