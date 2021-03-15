class UpdateBioTextForUsers < ActiveRecord::Migration[6.0]
  OLD_DEFAULT = "This user hasn't updated their bio yet.".freeze
  NEW_DEFAULT = "404 - bio not found".freeze

  def change
    change_column_default(:users, :bio, from: OLD_DEFAULT, to: NEW_DEFAULT)
    
    User.where(bio: OLD_DEFAULT).each { |u| u.update!(bio: NEW_DEFAULT) }
  end
end
