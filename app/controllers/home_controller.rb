class HomeController < ApplicationController
  def index
    if user_signed_in?
      @snippets = current_user.snippets_for_feed
        .map { |s| s.simple_serialize(current_user) } #this is currently hitting the db for every liked_by?
    else
      # temp fix for when user not signed in
      @snippets = Snippet.order(created_at: :desc).map { |s| s.simple_serialize(false) } #find a better solution to this
    end
  end
end
