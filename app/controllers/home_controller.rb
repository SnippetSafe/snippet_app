class HomeController < ApplicationController
  def index
    @snippets = Snippet.includes({ language: :aliases }, :user)
      .order(created_at: :desc)
      .map(&:simple_serialize)

    @languages = Language.order(name: :asc)
  end
end
