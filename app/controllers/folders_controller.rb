class FoldersController < ApplicationController
  MINIMUM_FOLDERS = 1.freeze

  before_action :authenticate_user!
  before_action :set_folder, only: %i(show edit update destroy)
  before_action :require_minimum_folders, only: :destroy

  def popover
    @folder = current_user.folders.find(params[:id])
    
    @popover_options = @folder.popover_options_for(current_user)

    render partial: 'shared/popover', layout: false
  end

  def index
    @page_title = 'Folders'

    @folders = current_user.folders

    @folders = @folders.where('name ILIKE ?', "%#{params[:search]}%") if params[:search].present?

    @folders = @folders
      .order(name: :asc)
      .paginate(page: params[:page] || 1, per_page: 20)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'folders/folders', locals: { folders: @folders }, formats: [:html]),
          pagination: view_context.will_paginate(@folders)
        }
      end
    end
  end

  def show
    @page_title = @folder.name
    @display_popover = true
    @snippets = @folder.snippets

    @snippets = @snippets.where('description ILIKE ?', "%#{params[:search]}%") if params[:search].present?

    @snippets = @snippets
      .order(created_at: :desc)
      .paginate(page: params[:page] || 1, per_page: 6)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'snippets/snippets', formats: [:html]),
          pagination: view_context.will_paginate(@snippets)
        }
      end
    end
  end

  def create
    @folder = Folder.create!(folder_params.merge(user: current_user))

    flash[:notice] = 'New folder created!'

    redirect_to folders_path
  end

  def edit

  end

  def update
    if @folder.update(folder_params)
      flash[:notice] = 'Folder updated!'
    else
      flash[:alert] = 'Unable to update folder'
    end

    redirect_to folders_path
  end

  def destroy
    respond_to do |format|
      format.html do
        if @folder.destroy
          flash[:notice] = 'Folder deleted!'
        else
          flash[:alert] = 'Unable to delete folder'
        end

        redirect_to folders_path
      end
    end
  end

  # Remove this once all routes no longer use JSON
  def unfile_snippet
    snippet_folder = current_user.snippet_folders.find_by(snippet_id: params[:snippet_id])

    if snippet_folder && snippet_folder.destroy
      render json: { message: 'Snippet removed from folder!' }
    else
      render json: { message: 'Failed to remove snippet from folder' }
    end
  end

  # Remove this once all routes no longer use JSON
  def file_snippet
    begin
      snippet = Snippet.find(params[:snippet_id])
      
      @folder = current_user.folders.find_by(id: params[:folder_id])

      @folder.snippets << snippet

      render json: { message: 'Added snippet to folder' }
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: e.record.errors.full_messages.join(', ') }, status: 400
    end
  end

  private

  def set_folder
    unless @folder = current_user.folders.find_by(id: params[:id])
      respond_to do |format|
        format.html { redirect_to root_path, alert: UNAUTHORIZED }
        format.json { render json: { message: UNAUTHORIZED }, status: 401 }
      end
    end
  end

  def require_minimum_folders
    if current_user.folders.size <= MINIMUM_FOLDERS
      render json: { message: 'Unable to delete your only folder' }, status: 400
    end
  end

  def folder_params
    params.require(:folder).permit(:name)
  end
end
