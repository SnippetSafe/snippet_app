class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: { comment: comment.serialize, message: 'Comment created!' }
    else
      render json: { errors: comment.errors.full_messages }, status: 400
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])

    if comment && comment.destroy
      render json: { message: 'Comment deleted!' }
    else
      render json: { message: 'Failed to delete comment' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:snippet_id, :user_id, :body)
  end
end
