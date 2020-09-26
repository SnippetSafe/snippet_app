class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @serialized_user = @user.serialize.to_json
    @is_following = current_user ? current_user.following?(@user) : false
    @followers = @user.followers
    @following = @user.following
    @display_popover = true
    @snippets = @user.filed_snippets
      .order(created_at: :desc)
      .paginate(page: 1, per_page: 6)
  end

  def hovercard
    @user = User.find(params[:id])
    @hovercard_position = params[:position]

    render layout: false
  end

  def modify
    current_user.assign_attributes(user_params)
    current_user.avatar.attach(avatar_param) if avatar_param

    if current_user.save
      render json: { message: "Profile updated", user: current_user.serialize }
    else
      render json: { errors: current_user.errors.full_messages }, status: 400
    end
  end

  def follow
    @user = User.find_by(id: params[:id])

    if current_user.follow(@user)
      flash[:notice] = "You are now following #{@user.name}."
    else
      flash[:alert] = "You are already following #{@user.name} you nutter!"
    end

    redirect_to user_path(@user)
  end

  def unfollow
    @user = User.find_by(id: params[:id])

    if current_user.unfollow(@user)
      flash[:notice] = "You are no longer following #{@user.name}."
    else
      flash[:alert] = "You can't unfollow someone you aren't following you nutter!"
    end

    redirect_to user_path(@user)
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
