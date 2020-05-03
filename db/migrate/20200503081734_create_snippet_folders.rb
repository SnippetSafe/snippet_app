class CreateSnippetFolders < ActiveRecord::Migration[6.0]
  def up
    drop_table :folders_snippets

    create_table :snippet_folders do |t|
      t.references :snippet, null: false, foreign_key: true
      t.references :folder, null: false, foreign_key: true
    end

    add_column :folders, :snippet_count, :integer, default: 0
  end

  def down
    create_table :folders_snippets, id: false do |t|
      t.belongs_to :snippet
      t.belongs_to :folder
    end

    drop_table :snippet_folders
    remove_column :folders, :snippet_count
  end
end
