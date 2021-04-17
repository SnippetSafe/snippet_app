class Shared::PopularController < ApplicationController
  def index
    @popular_snippets = Snippet.popular.includes(:language).limit(3)
  end
end