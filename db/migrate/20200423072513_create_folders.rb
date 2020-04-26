class CreateFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :folders do |t|
      t.references :user
      t.string :name, null: false
      t.timestamps
    end

    create_table :folders_snippets, id: false do |t|
      t.belongs_to :snippet
      t.belongs_to :folder
    end
  end
end
