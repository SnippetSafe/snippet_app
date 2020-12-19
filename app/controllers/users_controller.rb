class UsersController < ApplicationController
  def index
    users = User.limit(5)

    render json: { items: users }
  end

  def show
    @user = User.find_by(id: params[:id])
    @page_title = "#{@user.name}"
    @serialized_user = @user.serialize.to_json
    @is_following = current_user ? current_user.following?(@user) : false
    @followers = @user.followers
    @following = @user.following
    @display_popover = true

    # need to change current implementation to hit specific user snippets endpoint so can optionally show private ones
    if @user == current_user
      @snippets = @user.filed_snippets
        .order(created_at: :desc)
        .paginate(page: 1, per_page: 6)
    else
      @snippets = @user.filed_snippets.public_snippets
        .order(created_at: :desc)
        .paginate(page: 1, per_page: 6)
    end

    @tab_id = params[:tab_id] || :snippets
  end

  def hovercard
    @user = User.find(params[:id])
    @hovercard_position = params[:position]

    render layout: false
  end

  def modify
    respond_to do |format|
      format.html do
        current_user.assign_attributes(user_params)
        current_user.avatar.attach(avatar_param) if avatar_param
        
        if current_user.save
          flash[:notice] = "Profile updated"
        else
          flash[:alert] = "Failed to update profile"
        end
        
        redirect_to edit_user_registration_path(current_user)
      end
      
      format.json do
        current_user.avatar.attach(avatar_param)

        render json: { message: 'Avatar updated', avatar_url: current_user.avatar_url }
      end
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
