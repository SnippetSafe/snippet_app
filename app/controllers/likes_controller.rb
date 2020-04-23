class LikesController < ApplicationController
  def create
    like = Like.toggle(like_params[:user_id], like_params[:snippet_id])

    #TODO: Probably doesn't need to return the whole snippet, just toggle the count as it's hitting the DB a billion times for one like
    render json: { snippet: like.snippet.simple_serialize(current_user) }
  end

  private

  def like_params
    params.require(:like).permit(:snippet_id, :user_id)
  end
end
