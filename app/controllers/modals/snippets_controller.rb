class Modals::SnippetsController < ModalsController
  before_action :set_snippet, only: %i(edit)

  def new
    @snippet = Snippet.new
    @folders = current_user.folders
    @languages = Language.order(name: :asc)
    @javascript = @languages.find_by_name('JavaScript')
  end

  def edit
    @languages = Language.order(name: :asc)
    @folders = current_user.folders
    @folder = current_user.snippet_folders.find_by(snippet_id: params[:id]).folder
  end

  def move
    @snippet = Snippet.friendly.find(params[:id])
    @current_folder_id = current_user.snippet_folders.find_by(snippet_id: @snippet.id)&.folder&.id
    @header = @current_folder_id ? 'Move Snippet' : 'File Snippet'
    @folders = current_user.folders.order(name: :asc)
  end

  def picture
    @snippet = Snippet.friendly.find(params[:id])
    @languages = Language.order(name: :asc)
  end

  private

  def set_snippet
    unless @snippet = current_user.snippets.find_by(slug: params[:id])
      respond_to do |format|
        format.html { redirect_to root_path, alert: UNAUTHORIZED }
        format.json { render json: { message: UNAUTHORIZED }, status: 401 }
      end
    end
  end
end
