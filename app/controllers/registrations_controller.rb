class RegistrationsController < Devise::RegistrationsController
  # def create
  #   byebug
  #   super
  # end

  # def edit
  #   super do
  #     @page_title = 'Account'
  #   end
  # end

  def update
    current_user.updated_at = Time.now
    current_user.avatar.attach(params[:user][:avatar])
    current_user.save!
    # if current_user.update(account_update_params)
    #   render json: { message: "Profile updated" }
    # else
    #   render json: { message: "Failed to update profile" }, status: 400
    # end
  end
end
