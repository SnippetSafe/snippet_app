class Folders::SnippetsController < ApplicationController
  layout false

  def index
    @folder = Folder.find(params[:folder_id])
    @snippets = @folder.snippets
  end
end
