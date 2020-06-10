class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @following = current_user.following?(@user)
  end

  def followers
    @user = User.find_by(id: params[:id])
    @serialized_user = @user.serialize.to_json
    @is_following = current_user.following?(@user)
    @followers = @user.followers
  end

  def following
    @user = User.find_by(id: params[:id])
    @serialized_user = @user.serialize.to_json
    @is_following = current_user.following?(@user)
    @following = @user.following
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
end
