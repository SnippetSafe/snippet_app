class AddDefaultThemeToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :theme_id, from: nil, to: Theme.find_by_slug('one-dark').id
  end
end
