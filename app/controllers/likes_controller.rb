class LikesController < ApplicationController
  def create
    like = Like.toggle(like_params[:user_id], like_params[:snippet_id])

    render partial: 'shared/like_button', locals: { snippet: Snippet.find(like_params[:snippet_id])}
  end

  private

  def like_params
    params.require(:like).permit(:snippet_id, :user_id)
  end
end
