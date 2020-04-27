class SnippetsController < ApplicationController
  def show
    @snippet = Snippet.includes(comments: :user).find(params[:id]).serialize(current_user)
  end

  def new

  end

  def create
    # language = Language.find_by_filename(snippet_params[:filename])
    
    snippet = Snippet.create!(
      user: current_user,
      description: snippet_params[:description],
      body: snippet_params[:body],
      public: snippet_params[:public],
      language_id: snippet_params[:language_id]
    )

    render json: { snippet: snippet.serialize(current_user) }
  end

  private

  def snippet_params
    params.require(:snippet).permit(:description, :body, :public, :language_id)
  end
end
