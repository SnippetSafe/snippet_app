class RegistrationsController < Devise::RegistrationsController
  def update
    if current_user.update(sign_up_params)
      render json: { message: "Profile updated" }
    else
      render json: { message: "Failed to update profile" }, status: 400
    end
  end
end
