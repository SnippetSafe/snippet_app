class SessionsController < Devise::SessionsController
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
end
