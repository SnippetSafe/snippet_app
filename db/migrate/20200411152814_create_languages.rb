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
  end
end
