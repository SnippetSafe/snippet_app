class CommentsController < ApplicationController
  def create
    comment = Comment.create!(comment_params)

    render json: { comment: comment }
  end

  #TODO: Add abikity to delete comments

  private

  def comment_params
    params.require(:comment).permit(:snippet_id, :user_id, :body)
  end
end
