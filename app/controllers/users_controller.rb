class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @serialized_user = @user.serialize.to_json
    @is_following = current_user.following?(@user)
    @followers = @user.followers
    @following = @user.following
  end

  def modify
    current_user.assign_attributes(user_params)
    current_user.avatar.attach(avatar_param) if avatar_param

    if current_user.save
      render json: { message: "Profile updated" }
    else
      render json: { message: "Failed to update profile" }, status: 400
    end

    # current_user.updated_at = Time.now
    # current_user.avatar.attach(params[:user][:avatar])
    # current_user.save!
    # byebug
  end

  def follow
    @user = User.find_by(id: params[:id])

    if current_user.follow(@user)
      render json: { message: "You are now following #{@user.name}." }
    else
      render json: { message: "You are already following #{@user.name} you nutter!" }, status: 400
    end
  end

  def unfollow
    @user = User.find_by(id: params[:id])

    if current_user.unfollow(@user)
      render json: { message: "You are no longer following #{@user.name}." }
    else
      render json: { message: "You can't unfollow someone you aren't following you nutter!" }, status: 400
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :bio, :location)
      .merge(updated_at: Time.now) #This is to fix an activestorage bug
  end

  def avatar_param
    params[:user][:avatar]
  end
end
