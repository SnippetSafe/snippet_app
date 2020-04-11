class SnippetsController < ApplicationController
  def new

  end

  def create
    snippet = Snippet.create!(snippet_params)

    render json: { snippet: snippet.serialize }
  end

  private

  def snippet_params
    params.require(:snippet).permit(:description, :body, :public, :language_id)
  end
end
