class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy

  def create
    @snippet = Snippet.find(params[:snippet_id])
    @comment = @snippet.comments.new(comment_params)

    if @comment.save

      unless @snippet.user == @comment.user
        @comment.notifications.create(user: @snippet.user)
      end

      element = render_to_string partial: 'comments/comment', locals: { comment: @comment }

      render json: { element: element }
    else
      flash[:alert] = 'Comment body can\'t be empty.'
      redirect_to snippet_path(@snippet, anchor: 'comment_body')
    end
  end

  def destroy
    if @comment.destroy
      head :ok
    else
      # Not handling this event in browser
      head :bad_request
    end
  end

  def popover
    @comment = Comment.find(params[:id])

    @popover_options = @comment.popover_options_for(current_user)

    render partial: 'shared/popover', layout: false
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
    params.require(:comment).permit(:body).to_h.merge(user_id: current_user.id)
  end
end
