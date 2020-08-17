class HomeController < ApplicationController
  def index
    if user_signed_in?
      @page_title = 'Feed'
      @display_popover = true
      @snippets = current_user
        .snippets_for_feed
        .includes(:user)
    else
      # temp fix for when user not signed in
      @snippets = Snippet
        .includes(:user)
        .order(created_at: :desc)
    end
  end
end
