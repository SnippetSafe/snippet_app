class RegistrationsController < Devise::RegistrationsController
  def update
    if current_user.update(account_update_params)
      render json: { message: "Profile updated" }
    else
      render json: { message: "Failed to update profile" }, status: 400
    end
  end
end
