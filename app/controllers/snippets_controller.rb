class SnippetsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_snippet, only: %i(edit destroy)

  DELETE_CONFIRM_TEXT = "Are you sure you want to delete this snippet? You won't be able to undo this.".freeze
  UNFILE_CONFIRM_TEXT = "Are you sure you want to unfile this snippet? It will be removed from your collection.".freeze

  def index
    @page_title = 'Snippets'
  end

  def popover
    @snippet = Snippet.find(params[:id])

    @popover_options = current_user.popover_options_for(@snippet)

    render layout: false
  end

  # Does this belong on SnippetFoldersController?
  def unfile
    snippet_folder = current_user.snippet_folders.find_by(snippet_id: params[:id])

    if snippet_folder && snippet_folder.destroy
      flash[:notice] = "Snippet removed from collection!"
      redirect_to root_path
    else
      flash[:alert] = 'Failed to remove snippet from folder'
      redirect_to root_path
    end
  end

  # Does this belong on SnippetFoldersController?
  def file
    begin
      Snippet.transaction do
        if snippet_folder = current_user.snippet_folders.find_by(snippet_id: params[:id])
          snippet_folder.destroy!
        end  
    
        SnippetFolder.create!(snippet_id: params[:id], folder_id: params[:folder_id])
      end
    rescue => error
      flash[:alert] = 'Unable to file snippet, please try again.'
    else
      new_folder = current_user.folders.find(params[:folder_id])

      flash[:notice] = "Snippet filed in #{new_folder.name}!"
    end

    redirect_to root_path
  end

  def move_modal
    @snippet = Snippet.find(params[:id])
    @current_folder_id = current_user.snippet_folders.find_by(snippet_id: params[:id])&.folder&.id
    @header = @current_folder_id ? 'Move Snippet' : 'File Snippet'
    @folders = current_user.folders

    render layout: false
  end

  def delete_alert
    @snippet = current_user.snippets.find(params[:id])
    @title = 'Delete Snippet'
    @message = DELETE_CONFIRM_TEXT
    @confirm_word = 'DELETE'
    @confirm_path = snippet_path(@snippet)
    @method = :delete

    render layout: false
  end

  def unfile_alert
    @snippet = current_user.filed_snippets.find(params[:id])
    @title = 'Unfile Snippet'
    @message = UNFILE_CONFIRM_TEXT
    @confirm_word = 'UNFILE'
    @confirm_path = unfile_snippet_path(@snippet)
    @method = :delete

    render layout: false
  end

  def current_folder
    snippet_folder = current_user.snippet_folders.find_by(snippet_id: params[:id])

    res = { folders: current_user.folders.map { |folder| FolderSerializer.new(folder).to_h } }

    if snippet_folder
      res.merge!(current_folder: FolderSerializer.new(snippet_folder.folder).to_h)
    end

    render json: res
  end

  def search
    snippets = current_user.filed_snippets
      .includes(:user)
      .where('description ILIKE ?', "%#{search_params[:search_term]}%")
      .order(created_at: :desc)
      .offset(offset)
      .limit(params[:per_page])
      .map { |s| s.simple_serialize(current_user) }

    render json: { items: snippets }
  end

  def show
    @snippet = Snippet.includes(comments: :user).find(params[:id])
    @display_popover = true
    @comment = Comment.new
  end

  def new
    @page_title = 'New Snippet'

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

  def edit
    @snippet = @snippet.serialize(current_user).to_json
    @folders = current_user.folders.to_json
  end

  #TODO: Use a different controller action for moving a snippet between folders
  def update
    snippet = current_user.filed_snippets.find_by(id: params[:id])

    if snippet.update(snippet_params.except(:folder_id))
      folder = current_user.folders.find(snippet_params[:folder_id])

      Snippet.transaction do
        current_user.snippet_folders.find_by(snippet_id: params[:id]).destroy
        SnippetFolder.create!(snippet_id: params[:id], folder_id: snippet_params[:folder_id])
      end

      render json: { message: "Snippet moved to folder <strong>#{folder.name}<strong>" }

    else
      render json: { message: "Failed to update snippet", errors: @snippet.errors.full_messages }, status: 400
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        if @snippet.destroy
          flash[:notice] = 'Snippet deleted!'

          redirect_to root_path
        else
          flash[:alert] = 'Unable to delete snippet'

          redirect_to root_path
        end
      end
      format.json do
        if @snippet.destroy
          render json: { message: 'Snippet deleted!' }
        else
          render json: { message: 'Unable to delete snippet' }, status: 401
        end
      end
    end
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

  def offset
    (search_params[:page].to_i - 1) * search_params[:per_page].to_i 
  end

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

  def search_params
    params.permit(:search_term, :page, :per_page)
  end
end
