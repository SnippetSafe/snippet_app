class SnippetsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def index
    @page_title = 'Snippet'
    @user = User.find_by(id: params[:user_id]) || current_user
    @snippets = @user.filed_snippets.includes(:folders, :language, { user: { avatar_attachment: :blob } })
    @languages = Language.all.to_json

    # TODO: Extract this logic to model/service
    @snippets = @snippets.where('description ILIKE ?', "%#{params[:search]}%") if params[:search]

    @snippets = @snippets.order(created_at: :desc)
    
    @pagy, @snippets = pagy(@snippets, items: 6)

    respond_to do |format|
      format.html do
        flash[:notice] = params[:notice] if params[:notice]
      end
      format.json do
        render json: {
          entries: render_to_string(partial: 'snippets/snippets', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end

  def popover
    @snippet = Snippet.friendly.find(params[:id])

    @popover_options = current_user.popover_options_for(@snippet)

    render partial: 'shared/popover', layout: false, formats: [:html]
  end

  # Does this belong on SnippetFoldersController?
  def unfile
    snippet = current_user.filed_snippets.friendly.find(params[:id])
    snippet_folder = current_user.snippet_folders.find_by(snippet_id: snippet.id)

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
    respond_to do |format|
      format.json do
        begin
          Snippet.transaction do
            snippet = Snippet.friendly.find(params[:id])

            if snippet_folder = current_user.snippet_folders.find_by(snippet_id: snippet.id)
              snippet_folder.destroy!
            end  
        
            snippet_folder = SnippetFolder.create!(snippet_id: snippet.id, folder_id: params[:folder_id])

            unless current_user == snippet.user
              snippet_folder.notifications.create!(user: snippet.user)
            end
          end
        rescue => error
          render json: { message: 'Unable to file snippet, please try again.' }, status: 400
        else
          new_folder = current_user.folders.find(params[:folder_id])
          render json: { message: "Snippet filed in #{new_folder.name}!" }
        end
      end
    end
  end

  def current_folder
    snippet = Snippet.friendly.find(params[:id])
    snippet_folder = current_user.snippet_folders.find_by(snippet_id: snippet.id)

    res = { folders: current_user.folders.map { |folder| FolderSerializer.new(folder).to_h } }

    if snippet_folder
      res.merge!(current_folder: FolderSerializer.new(snippet_folder.folder).to_h)
    end

    render json: res
  end

  def show
    @page_title = "Snippet"
    @languages = Language.all.to_json
    @snippet = Snippet.includes(comments: :user).find_by(slug: params[:id])

    unless @snippet && @snippet.visible_to?(current_user)
      flash[:alert] = "You are not authorized to view that snippet"
      redirect_to root_path
    end

    @comment = Comment.new
  end

  def new
    @snippet = Snippet.new

    if params[:folder_id]
      @folder_id = params[:folder_id]
      @redirect_url = params[:redirect_url]
    end
    @folders = current_user.folders
  end

  def create
    respond_to do |format|
      format.turbo_stream do
        @snippet = Snippet.new(
          user: current_user,
          description: snippet_params[:description],
          body: snippet_params[:body],
          public: snippet_params[:public],
          language_id: snippet_params[:language_id],
        )
    
        if snippet_params[:folder_id].present?
          folder = current_user.folders.find(snippet_params[:folder_id])
          @snippet.folders << folder
        end
    
        @snippet.save
      end
    end
  end

  #TODO: Use a different controller action for moving a snippet between folders
  def update
    snippet = current_user.filed_snippets.find_by(slug: params[:id])

    if snippet.update(snippet_params.except(:folder_id))
      folder = current_user.folders.find(snippet_params[:folder_id])

      Snippet.transaction do
        snippet_folder = current_user.snippet_folders.find_by(snippet_id: snippet.id)

        if snippet_folder.folder_id != snippet_params[:folder_id].to_i
          snippet_folder.update!(folder_id: snippet_params[:folder_id])
        end
      end

      partial = if URI(request.referer).path == snippet_path(snippet)
        'snippets/snippet'
      else
        'snippets/snippet_preview'
      end

      @languages = Language.all.to_json
      element = render_to_string partial: partial, locals: { snippet: snippet }

      render json: { client_id: snippet.client_id, folder_id: snippet_params[:folder_id], element: element }
    else
      element = render_to_string partial: 'shared/errors', locals: { resource: snippet }
      render json: { element: element }, status: :bad_request
    end
  end

  def destroy
    @snippet = current_user.snippets.friendly.find(params[:id])

    if @snippet&.destroy
      render json: { resource_id: @snippet.client_id }
    else
      head :bad_request
    end
  end

  private

  def snippet_params
    params.require(:snippet).permit(
      :description,
      :body,
      :public,
      :language_id,
      :folder_id
    )
  end

  def search_params
    params.permit(:search_term, :page, :per_page)
  end
end
