class Modals::SnippetsController < ModalsController
  before_action :set_snippet, only: %i(edit)

  def new
    @snippet = Snippet.new
    @folders = current_user.folders
    @languages = Language.order(name: :asc)
    @javascript = @languages.find_by_slug('javascript')
  end

  def edit
    @languages = Language.order(name: :asc)
    @folders = current_user.folders
    @folder = current_user.snippet_folders.find_by(snippet_id: params[:id]).folder
  end

  def move
    @snippet = Snippet.find(params[:id])
    @current_folder_id = current_user.snippet_folders.find_by(snippet_id: params[:id])&.folder&.id
    @header = @current_folder_id ? 'Move Snippet' : 'File Snippet'
    @folders = current_user.folders
  end

  private

  def set_snippet
    unless @snippet = current_user.snippets.find_by(id: params[:id])
      respond_to do |format|
        format.html { redirect_to root_path, alert: UNAUTHORIZED }
        format.json { render json: { message: UNAUTHORIZED }, status: 401 }
      end
    end
  end
end
