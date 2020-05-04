class FoldersController < ApplicationController
  before_action :authenticate_user!
  def index
    @folders = current_user.folders.includes([:snippets, :snippet_folders]).order(created_at: :asc)
  end

  def show
    @folder = Folder.find(params[:id])
    @snippets = @folder.snippets
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
