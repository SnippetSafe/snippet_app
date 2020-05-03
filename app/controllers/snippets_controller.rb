class SnippetsController < ApplicationController
  before_action :authenticate_user!

  def show
    @snippet = Snippet.includes(comments: :user).find(params[:id]).serialize(current_user)
  end

  def new
    @folders = current_user.folders.to_json
  end

  def create
    snippet = Snippet.new(
      user: current_user,
      description: snippet_params[:description],
      body: snippet_params[:body],
      highlighted_body: snippet_params[:highlighted_body],
      public: snippet_params[:public],
      language: snippet_params[:language],
    )

    if snippet_params[:folder_id]
      folder = Folder.find(snippet_params[:folder_id])
      snippet.folders << folder
    end

    if snippet.save
      render json: { snippet: snippet.serialize(current_user) }
    else
      render json: { errors: snippet.errors.full_messages }, status: 400
    end
  end

  private

  def snippet_params
    params.require(:snippet).permit(
      :description,
      :body,
      :highlighted_body,
      :public,
      :language,
      :folder_id
    )
  end
end
