class FoldersController < ApplicationController
  before_action :authenticate_user!
  def index
    @folders = current_user.folders.includes([:snippets, :snippet_folders]).order(created_at: :asc)
      .map { |folder| FolderSerializer.new(folder).to_h }
  end

  def show
    @folder = Folder.find(params[:id])
    @snippets = @folder.snippets.order(created_at: :desc).map { |s| s.serialize(current_user) }
  end

  def new

  end

  def create
    @folder = Folder.create!(folder_params.merge(user: current_user))

    redirect_to @folder
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
