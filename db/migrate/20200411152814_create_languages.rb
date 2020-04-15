class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :aliases do |t|
      t.string :name, null: false
      t.references :language

      t.timestamps
    end

    create_table :filenames do |t|
      t.string :name, null: false
      t.references :language

      t.timestamps
    end

    create_table :mimetypes do |t|
      t.string :name, null: false
      t.references :language

      t.timestamps
    end


    add_reference :snippets, :language

    Pygments.lexers.each do |name, options|
      language = Language.create!(name: name)

      options[:aliases].each do |alias_name|
        Alias.create!(
          name: alias_name,
          language: language
        )
      end

      options[:filenames].each do |filename|
        Filename.create!(
          name: filename,
          language: language
        )
      end

      options[:mimetypes].each do |mimetype|
        Mimetype.create!(
          name: mimetype,
          language: language
        )
      end
    end
  end
end
