class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy

  DELETE_CONFIRM_TEXT = "Are you sure you want to delete this comment? You won't be able to undo this.".freeze

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: { comment: comment.serialize, message: 'Comment created!' }
    else
      render json: { errors: comment.errors.full_messages }, status: 400
    end
  end

  def destroy
    snippet = @comment.snippet

    if @comment.destroy
      flash[:notice] = 'Comment deleted!'
    else
      flash[:alert] = 'Failed to delete comment'
    end

    redirect_to snippet_path(snippet)
  end

  def popover
    @comment = Comment.find(params[:id])

    @popover_options = @comment.popover_options_for(current_user)

    render layout: false
  end

  def delete_alert
    @comment = current_user.comments.find(params[:id])
    @title = 'Delete Comment'
    @message = DELETE_CONFIRM_TEXT
    @confirm_word = 'DELETE'
    @confirm_path = comment_path(@comment)
    @method = :delete

    render layout: false, partial: 'shared/alert'
  end

  private

  def set_comment
    unless @comment = current_user.comments.find_by(id: params[:id])
      respond_to do |format|
        format.html { redirect_to root_path, alert: UNAUTHORIZED }
        format.json { render json: { message: UNAUTHORIZED }, status: 401 }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:snippet_id, :user_id, :body)
  end
end
