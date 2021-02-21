class HomeController < ApplicationController
  def index
    @page_title = 'Home'
    @display_popover = true

    @languages = Language.order(name: :asc).to_json

    if user_signed_in?
      @snippets = current_user
        .snippets_for_feed
        .includes(:language)
        .paginate(page: params[:page] || 1, per_page: 6)
    else
      # temp fix for when user not signed in
      @snippets = Snippet
        .public_snippets
        .includes(:user, :language)
        .order(created_at: :desc)
        .paginate(page: params[:page] || 1, per_page: 6)
    end

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'snippets/snippets', formats: [:html]),
          pagination: view_context.will_paginate(@snippets)
        }
      end
    end
  end

  def connect
    @users = if user_signed_in?
      current_user.not_following
      .paginate(page: params[:page] || 1, per_page: 16)
    else
      User.order(updated_at: :desc)
      .paginate(page: params[:page] || 1, per_page: 16)
    end

    # TODO: Extract this logic to model/service
    @users = @users.where('name ILIKE ?', "%#{params[:search]}%") if params[:search]

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'users/follow_previews', formats: [:html]),
          pagination: view_context.will_paginate(@users)
        }
      end
    end
  end
end
