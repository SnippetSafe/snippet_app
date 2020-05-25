class FoldersController < ApplicationController
  before_action :authenticate_user!
  def index
    respond_to do |format|
      format.html do 
        @folders = current_user.folders.includes([:snippets, :snippet_folders]).order(created_at: :asc)
          .map { |folder| FolderSerializer.new(folder).to_h }
      end

      format.json do
        render json: { folders: current_user.folders.order(name: :asc) }
      end
    end
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
      render json: { message: 'Unable to delete folder' }
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
