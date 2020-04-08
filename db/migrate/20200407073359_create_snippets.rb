class CreateSnippets < ActiveRecord::Migration[6.0]
  def change
    create_table :snippets do |t|
      t.string :description
      t.text :body
      t.boolean :public

      t.timestamps
    end
  end
end
