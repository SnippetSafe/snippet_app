class HomeController < ApplicationController
  def index
    @snippets = Snippet.all
  end
end
