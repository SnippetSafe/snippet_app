class RegistrationsController < Devise::RegistrationsController
  layout 'application', only: %i(edit update)

  def create
    respond_to do |format|
      format.html { super }
      format.json do
        user = User.new(user_params)

        if user.save
          render json: { message: 'Thanks for signing up, please confirm your email to sign in.' }
        else
          render json: { message: 'There was a problem creating your account.' }, status: 400
        end
      end
    end
  end

  def edit
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
end
