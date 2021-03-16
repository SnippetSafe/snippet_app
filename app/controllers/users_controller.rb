class UsersController < ApplicationController
  def index
    users = User.limit(5)

    render json: { items: users }
  end

  def show
    respond_to do |format|
      format.html do
        @user = User.find_by(slug: params[:id])
        @page_title = "#{@user.name}"
        @serialized_user = @user.serialize.to_json
        @is_following = current_user ? current_user.following?(@user) : false
        @followers = @user.followers
        @following = @user.following
        @display_popover = true
        @languages = Language.all.to_json
    
        # need to change current implementation to hit specific user snippets endpoint so can optionally show private ones
        snippets = if @user == current_user
          @user.filed_snippets.includes(:language)
            .order(created_at: :desc)
        else
          @user.filed_snippets.public_snippets.includes(:language)
            .order(created_at: :desc)
        end
    
        @pagy, @snippets = pagy(snippets, items: 6)
    
        @tab_id = params[:tab_id] || :snippets
      end

      format.json do
        @user = User.find_by(slug: params[:id])
        @snippets = @user.filed_snippets.includes(:user, :folders, :language)
        @languages = Language.all.to_json

        # TODO: Extract this logic to model/service
        @snippets = @snippets.where('description ILIKE ?', "%#{params[:search]}%") if params[:search]

        @snippets = @snippets.order(created_at: :desc)
        
        @pagy, @snippets = pagy(@snippets, items: 6)
        render json: {
          entries: render_to_string(partial: 'snippets/snippets', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
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

    current_user.follow(@user)
    
    render partial: 'users/follow_button', locals: { user: @user }
  end

  def unfollow
    @user = User.find_by(id: params[:id])

    current_user.unfollow(@user)

    render partial: 'users/follow_button', locals: { user: @user }
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
