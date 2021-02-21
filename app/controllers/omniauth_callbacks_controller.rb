class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	# See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
	skip_before_action :verify_authenticity_token, only: :github
	
	def github
		# You need to implement the method below in your model (e.g. app/models/user.rb)
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			flash[:notice] = 'Signed in from GitHub'
			sign_in_and_redirect @user# this will throw if @user is not activated
		else
			# byebug
			# session["devise.github_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
			redirect_to new_user_registration_url(notice: 'Unable to sign in with Github. Perhaps you already signed up with the associated email?')
		end
	end

	def failure
    redirect_to root_path
  end
end