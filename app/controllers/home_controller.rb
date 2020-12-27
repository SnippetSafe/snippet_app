class HomeController < ApplicationController
  before_action :authenticate_user!, only: :connect

  def index
    @display_popover = true

    if user_signed_in?
      @page_title = 'Feed'
      @snippets = current_user
        .snippets_for_feed
        .paginate(page: params[:page] || 1, per_page: 6)
    else
      # temp fix for when user not signed in
      @snippets = Snippet
        .public_snippets
        .includes(:user)
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
    @page_title = 'Connect'
    @users = current_user.not_following

    # @users = current_user.not_following

    # @users = @users
    #   .order(created_at: :desc)
    #   .paginate(page: params[:page] || 1, per_page: 15)

    # respond_to do |format|
    #   format.json do
    #     render json: {
    #       entries: render_to_string(partial: 'snippets/snippets', formats: [:html]),
    #       pagination: view_context.will_paginate(@users)
    #     }
    #   end
    # end
  end
end
