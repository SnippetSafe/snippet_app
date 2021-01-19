class Folders::SnippetsController < ApplicationController
  layout false

  def index
    @display_popover = true
    @folder = Folder.find(params[:folder_id])
    @snippets = @folder.snippets
  end
end
