class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: { comment: comment.serialize, message: 'Comment created!' }
    else
      render json: { errors: comment.errors.full_messages }, status: 400
    end
  end

  def destroy
    if @comment.destroy
      render json: { message: 'Comment deleted!' }
    else
      render json: { message: 'Failed to delete comment' }
    end
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
