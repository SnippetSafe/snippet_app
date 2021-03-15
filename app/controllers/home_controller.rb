class HomeController < ApplicationController
  SNIPPETS_PER_PAGE = 6.freeze
  CONNECT_USERS_PER_PAGE = 16.freeze

  def index
    @page_title = 'Home'
    @display_popover = true

    @languages = Language.order(name: :asc).to_json

    snippets = if user_signed_in?
      @snippets = current_user
        .snippets_for_feed
        .includes(:language, :likes, user: { avatar_attachment: :blob })
    else
      # temp fix for when user not signed in
      Snippet
        .public_snippets
        .includes(:user, :language)
        .order(created_at: :desc)
    end

    @pagy, @snippets = pagy(snippets, items: SNIPPETS_PER_PAGE)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'snippets/snippets', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end

  def connect
    users = if user_signed_in?
      current_user.not_following
    else
      User.order(updated_at: :desc)
    end

    # TODO: Extract this logic to model/service
    users = users.where('name ILIKE ?', "%#{params[:search]}%") if params[:search]

    @pagy, @users = pagy(users, items: CONNECT_USERS_PER_PAGE)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'users/follow_previews', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end
end
