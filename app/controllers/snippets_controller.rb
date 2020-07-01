class SnippetsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def index
    @snippets = current_user.filed_snippets
      .includes(:user)
      .order(created_at: :desc)
      .map { |s| s.simple_serialize(current_user) }
  end

  def show
    @snippet = Snippet.includes(comments: :user).find(params[:id]).serialize(current_user)
  end

  def new
    if params[:folder_id]
      @folder_id = params[:folder_id]
      @redirect_url = params[:redirect_url]
    end
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
      folder = current_user.folders.find(snippet_params[:folder_id])
      snippet.folders << folder
    end

    if snippet.save
      render json: { snippet: snippet.serialize(current_user) }
    else
      render json: { errors: snippet.errors.full_messages }, status: 400
    end
  end

  #TODO: Make it so that a user can only have a snippet in ONE of their folders
  def update
    folder = current_user.folders.find(snippet_params[:folder_id])

    Snippet.transaction do
      current_user.snippet_folders.find_by(snippet_id: params[:id]).destroy
      SnippetFolder.create!(snippet_id: params[:id], folder_id: snippet_params[:folder_id])
    end

    render json: { message: "Snippet moved to folder <strong>#{folder.name}<strong>" }
  end

  def destroy
    snippet = current_user.snippets.find_by(id: params[:id])

    if snippet
      if snippet.destroy
        render json: { message: 'Snippet deleted!' }
      else
        render json: { message: 'Unable to delete snippet' }, status: 401
      end
    else
      render json: { message: "You can't delete a snippet that you didn't create!" }, status: 400
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
