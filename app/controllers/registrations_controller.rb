class RegistrationsController < Devise::RegistrationsController
  layout :pick_layout

  def new
    @user = User.new
    @header = 'Sign up for an account'
    @sub_header = "Already have an account? #{view_context.link_to('Sign in', new_user_session_path, class: "text-cyan hover:text-cyan-hover")}".html_safe

    super
  end

  def create
    respond_to do |format|
      format.html do 
        @user = User.new
        @header = 'Sign up for an account'
        @sub_header = "Already have an account? #{view_context.link_to('Sign in', new_user_session_path, class: "text-cyan hover:text-cyan-hover")}".html_safe

        super
      end

      format.json do
        user = User.new(user_params)

        if user.save
          render json: { message: 'Thanks for signing up, please confirm your email to sign in.' }
        else
          element = render_to_string partial: 'shared/errors', locals: { resource: user }, formats: [:html]
          render json: { element: element, message: 'There was a problem creating your account.' }, status: 400
        end
      end
    end
  end

  def edit
    @page_title = 'Account'
    @tab_id = params[:tab_id] || :account
    super
  end

  def update
    @tab_id = :security
    super
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  APPLICATION_LAYOUTS = %w(edit update).freeze

  def pick_layout
    APPLICATION_LAYOUTS.include?(action_name) ? 'application' : 'modal_fake'
  end
end
