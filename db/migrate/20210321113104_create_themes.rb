class CreateThemes < ActiveRecord::Migration[6.0]
  def up
    create_table :themes do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :custom, null: false

      t.timestamps
    end

    THEMES.each { |theme_attrs| Theme.create!(theme_attrs) }
    
    add_reference :users, :theme, foreign_key: true

    one_dark = Theme.find_by_slug('one-dark')
    User.find_each { |u| u.update!(theme: one_dark) }
  end

  def down
    remove_reference :users, :theme
    drop_table :themes
  end
end
