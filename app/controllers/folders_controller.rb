class FoldersController < ApplicationController
  MINIMUM_FOLDERS = 1.freeze

  before_action :authenticate_user!
  before_action :require_minimum_folders, only: :destroy

  def index
    respond_to do |format|
      folders = current_user.folders
        .includes([:snippets, :snippet_folders])
        .order(created_at: :asc)
        .map { |folder| FolderSerializer.new(folder).to_h }

      format.html { @folders = folders }

      format.json do
        render json: { folders: folders }
      end
    end
  end

  def search
    folders = current_user.folders
      .includes([:snippets, :snippet_folders])
      .where('name ILIKE ?', "%#{search_params[:search_term]}%")
      .order(created_at: :desc)
      .offset(offset)
      .limit(params[:per_page])
      .map { |folder| FolderSerializer.new(folder).to_h }

    render json: { folders: folders }
  end

  def show
    @folder = Folder.find(params[:id])
    @snippets = @folder.snippets.order(created_at: :desc).map { |s| s.serialize(current_user) }
  end

  def new

  end

  def create
    @folder = Folder.create!(folder_params.merge(user: current_user))

    flash[:notice] = 'New folder created!'

    redirect_to folders_path
  end

  def update
    folder = current_user.folders.find_by(id: params[:id])

    if folder.update(folder_params)
      render json: { message: 'Folder updated!' }
    else
      render json: { message: 'Unable to update folder' }
    end
  end

  def destroy
    folder = current_user.folders.find_by(id: params[:id])

    if folder && folder.destroy
      render json: { message: 'Folder deleted!' }
    else
      render json: { message: 'Unable to delete folder' }, status: 400
    end
  end

  # move these to snippets controller
  def unfile_snippet
    snippet_folder = SnippetFolder.find_by(
      folder_id: params[:folder_id],
      snippet_id: params[:snippet_id]
    )

    if snippet_folder.destroy
      render json: { message: 'Snippet removed from folder!' }
    else
      render json: { message: 'Failed to remove snippet from folder' }
    end
  end

  # move these to snippets controller
  def file_snippet
    begin
      folder = current_user.folders.find_by(id: params[:folder_id])
      snippet = Snippet.find(params[:snippet_id])
      
      folder.snippets << snippet
      
      render json: { message: 'Added snippet to folder' }
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: e.record.errors.full_messages.join(', ') }, status: 400
    end
  end

  private

  def require_minimum_folders
    if current_user.folders.size <= MINIMUM_FOLDERS
      render json: { message: 'Unable to delete your only folder' }, status: 400
    end
  end

  def folder_params
    params.require(:folder).permit(:name)
  end

  def search_params
    params.permit(:search_term, :page, :per_page)
  end

  def offset
    (search_params[:page].to_i - 1) * search_params[:per_page].to_i 
  end
end
