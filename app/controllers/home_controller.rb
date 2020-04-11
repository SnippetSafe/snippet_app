class HomeController < ApplicationController
  def index
    @snippets = Snippet.order(created_at: :desc).map(&:serialize)
    @languages = Language.order(name: :asc)
  end
end
