class AddCommentsCountToSnippets < ActiveRecord::Migration[6.0]
  def change
    add_column :snippets, :comments_count, :integer, default: 0
  end
end
