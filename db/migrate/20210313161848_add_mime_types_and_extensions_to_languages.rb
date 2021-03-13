class AddMimeTypesAndExtensionsToLanguages < ActiveRecord::Migration[6.0]
  def change
    add_column :languages, :mime_types, :jsonb, default: ['text/plain'], null: false
    add_column :languages, :extensions, :jsonb, default: ['txt'], null: false
  end
end
