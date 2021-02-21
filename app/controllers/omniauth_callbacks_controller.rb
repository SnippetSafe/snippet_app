class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	# See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
	skip_before_action :verify_authenticity_token, only: :github
	
	def github
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			sign_in_and_redirect @user
		else
			redirect_to new_user_registration_url(notice: 'Unable to sign in with Github.')
		end
	end

	def failure
    redirect_to root_path
  end
end