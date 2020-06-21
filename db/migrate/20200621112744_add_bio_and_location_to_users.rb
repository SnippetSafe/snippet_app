class AddBioAndLocationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bio, :string, default: ''
    add_column :users, :location, :string, default: ''
  end
end
