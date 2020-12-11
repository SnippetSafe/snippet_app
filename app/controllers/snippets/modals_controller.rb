class Snippets::ModalsController < ModalsController
  def new
    @snippet = Snippet.new
    @folders = current_user.folders
  end
end
