class Shared::SnippetsController < ApplicationController
  PER_PAGE = 8.freeze

  def index
    @languages = Language.order(name: :asc).to_json

    @snippets = current_user
        .snippets_for_feed
        .includes(:language, :likes, user: { avatar_attachment: :blob })
    
    @snippets = @snippets.offset(offset).limit(PER_PAGE)

    @next_page = @page + 1 if @snippets.any?
  end

  private

  def page
    @page ||= params[:page] ? params[:page].to_i : 1
  end

  def offset
    @offset ||= (page - 1) * PER_PAGE
  end
end