class Alerts::CommentsController < AlertsController
  DELETE_CONFIRM_TEXT = "Are you sure you want to delete this comment? You won't be able to undo this.".freeze

  def delete
    @comment = current_user.comments.find(params[:id])
    @header = 'Delete Comment'
    @message = DELETE_CONFIRM_TEXT
  end
end
