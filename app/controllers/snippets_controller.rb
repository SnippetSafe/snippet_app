class SnippetsController < ApplicationController
  def show
    @snippet = Snippet.includes(comments: :user).find(params[:id]).serialize(current_user)
  end

  def create
    language = Language.find_by_filename(snippet_params[:filename])
  
    snippet = Snippet.create!(
      filename: snippet_params[:filename],
      description: snippet_params[:description],
      body: snippet_params[:body],
      public: snippet_params[:public],
      language: language
    )

    render json: { snippet: snippet.serialize }
  end

  private

  def snippet_params
    params.require(:snippet).permit(:description, :body, :public, :filename)
  end
end
