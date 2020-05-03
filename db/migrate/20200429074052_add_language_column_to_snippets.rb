class AddLanguageColumnToSnippets < ActiveRecord::Migration[6.0]
  def change
    add_column :snippets, :language, :string, default: 'plaintext'
    add_column :snippets, :highlighted_body, :string
    remove_column :snippets, :language_id, :integer
    drop_table :languages
    drop_table :aliases
    drop_table :filenames
    drop_table :mimetypes
  end
end
