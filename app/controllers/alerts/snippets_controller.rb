class Alerts::SnippetsController < AlertsController
  UNFILE_CONFIRM_TEXT = "Are you sure you want to unfile this snippet? It will be removed from your collection.".freeze
  DELETE_CONFIRM_TEXT = "Are you sure you want to delete this snippet? You won't be able to undo this.".freeze

  def unfile
    @snippet = current_user.filed_snippets.find(params[:id])
    @header = 'Unfile Snippet'
    @message = UNFILE_CONFIRM_TEXT
  end

  def delete
    @snippet = current_user.snippets.find(params[:id])
    @header = 'Delete Snippet'
    @message = DELETE_CONFIRM_TEXT
  end
end
