class RecreateLanguages < ActiveRecord::Migration[6.0]
  def up
    create_table :languages do |t|
      t.string :name, null: false
      
      t.timestamps
    end

    Language.transaction do
      LANGUAGES.each do |attrs|
        Language.create!(name: attrs[:name])
      end
    end
    
    remove_column(:snippets, :language)
    add_reference(:snippets, :language)

    Snippet.transaction do
      Snippet.all.update(language: Language.first)
    end
  end

  def down
    drop_table :languages
    add_column :snippets, :language, :string
    remove_reference :snippets, :language
  end
end
