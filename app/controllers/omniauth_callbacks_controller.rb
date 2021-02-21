class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	# See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
	skip_before_action :verify_authenticity_token, only: :github

	GITHUB_OMNIAUTH_FAIL_MESSAGE = 'Unable to sign in with Github.'.freeze
	
	def github
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			sign_in_and_redirect @user
		else
			redirect_to new_user_registration_url(notice: GITHUB_OMNIAUTH_FAIL_MESSAGE)
		end
	end

	def failure
    redirect_to root_path(notice: GITHUB_OMNIAUTH_FAIL_MESSAGE)
  end
end