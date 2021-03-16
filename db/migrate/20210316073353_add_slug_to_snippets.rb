class AddSlugToSnippets < ActiveRecord::Migration[6.0]
  def change
    add_column :snippets, :slug, :string
    add_index :snippets, :slug, unique: true

    Snippet.find_each(&:save!)
  end
end
