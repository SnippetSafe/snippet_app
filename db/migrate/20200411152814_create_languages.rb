class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :alias

      t.timestamps
    end

    add_reference :snippets, :language

    Pygments.lexers.each do |name, options|
      Language.create!(name: name, alias: options[:aliases].first)
    end
  end
end
