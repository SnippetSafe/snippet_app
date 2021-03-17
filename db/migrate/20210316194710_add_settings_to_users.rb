class AddSettingsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :settings, :jsonb, default: { 'theme' => 'one-dark' }
  end
end
