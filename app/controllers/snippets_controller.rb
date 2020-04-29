class SnippetsController < ApplicationController
  def show
    @snippet = Snippet.includes(comments: :user).find(params[:id]).serialize(current_user)
  end

  def new

  end

  def create
    snippet = Snippet.create!(
      user: current_user,
      description: snippet_params[:description],
      body: snippet_params[:body],
      highlighted_body: snippet_params[:highlighted_body],
      public: snippet_params[:public],
      language: snippet_params[:language]
    )

    render json: { snippet: snippet.serialize(current_user) }
  end

  private

  def snippet_params
    params.require(:snippet).permit(:description, :body, :highlighted_body, :public, :language)
  end
end
