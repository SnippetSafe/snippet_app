class SnippetsController < ApplicationController
  def new

  end

  def create
    snippet = Snippet.create!(snippet_params)

    render json: { snippet: snippet }
  end

  private

  def snippet_params
    params.require(:snippet).permit(:description, :body, :public)
  end
end
