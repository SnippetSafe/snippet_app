class HomeController < ApplicationController
  def index
    if user_signed_in?
      @snippets = Snippet.includes(:user)
        .order(created_at: :desc)
        .map { |s| s.simple_serialize(current_user) } #this is currently hitting the db for every liked_by?
    else
      # temp fix for when user not signed in
      @snippets = []
    end

    # @languages = Language.order(name: :asc)
  end
end
