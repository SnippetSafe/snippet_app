class HomeController < ApplicationController
  def index
    @snippets = Snippet.includes({ language: :aliases }, :user)
      .order(created_at: :desc)
      .map { |s| s.simple_serialize(current_user) } #this is currently hitting the db for every liked_by?

    @languages = Language.order(name: :asc)
  end
end
