class HomeController < ApplicationController
  SNIPPETS_PER_PAGE = 6.freeze
  CONNECT_USERS_PER_PAGE = 16.freeze

  def index

    respond_to do |format|
      format.html { @next_page = true }
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
