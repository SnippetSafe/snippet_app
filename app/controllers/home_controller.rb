class HomeController < ApplicationController
  def index
    @snippets = Snippet.includes(language: :aliases)
      .order(created_at: :desc)
      .map(&:serialize)

    @languages = Language.order(name: :asc)
  end
end
