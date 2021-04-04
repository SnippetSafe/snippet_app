class SessionsController < Devise::SessionsController
  layout 'basic'

  before_action :set_content, only: :new

  def create
    respond_to do |format|
      format.html { super }
      format.json do
        user = User.authenticate(user_params)

        if user
          sign_in(user)
          render json: { message: 'You are now logged in!' }
        else
          render json: { message: 'Invalid Email or Password.' }, status: 400
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_content
    @header = "Sign in to your account"
    @sub_header = "Don't have an account yet? #{view_context.link_to('Sign up', new_user_registration_path, class: "text-cyan hover:text-cyan-hover font-medium")}".html_safe
  end
end
