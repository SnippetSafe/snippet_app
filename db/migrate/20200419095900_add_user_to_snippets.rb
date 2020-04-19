class AddUserToSnippets < ActiveRecord::Migration[6.0]
  def change
    add_reference :snippets, :user, index: true
  end
end
