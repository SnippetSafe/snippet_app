class RecreateLanguages < ActiveRecord::Migration[6.0]
  def up
    create_table :languages do |t|
      t.string :name, null: false
      t.string :slug, null: false
      
      t.timestamps
    end

    Language.transaction do
      LANGUAGES.each do |name, slug|
        lang = Language.find_by_slug(slug)

        if lang
          lang.update!(name: name)
        else
          Language.create!(name: name, slug: slug)
        end
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
