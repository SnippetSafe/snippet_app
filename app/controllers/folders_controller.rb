class FoldersController < ApplicationController
  def index
    @folders = current_user.folders.order(name: :asc)
  end

  def show
    @folder = Folder.find(params[:id])
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
