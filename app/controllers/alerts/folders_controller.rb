class Alerts::FoldersController < AlertsController
  DELETE_CONFIRM_TEXT = "Are you sure you want to delete this folder? You won't be able to undo this.".freeze

  def delete
    @folder = current_user.folders.find(params[:id])
    @header = 'Delete Folder'
    @message = DELETE_CONFIRM_TEXT
  end
end
