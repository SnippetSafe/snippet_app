class Modals::UsersController < ModalsController
  def sign_in_sign_up
    @header = 'Sign in to continue'
    @sub_header = 'Create an account to stay in the loop!'
  end

  def sign_in
    @user = User.new
    @header = "Sign in to your account"
    @sub_header = "Don't have an account yet? #{view_context.link_to('Sign up', '', class: "text-cyan hover:text-cyan-hover", data: { controller: 'modal', modal_url_value: sign_up_modals_users_path, action: 'click->modal#present' })}".html_safe
    @footer = view_context.link_to("Didn't receive confirmation instructions?", new_user_confirmation_path).html_safe
  end

  def sign_up
    @user = User.new
    @header = 'Sign up for an account'
    @sub_header = "Already have an account? #{view_context.link_to('Sign in', '', class: "text-cyan hover:text-cyan-hover", data: { controller: 'modal', modal_url_value: sign_in_modals_users_path, action: 'click->modal#present' })}".html_safe
  end

  def edit_avatar; end

  def email_confirm; end
end
