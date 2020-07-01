class AddDefaultBioTextToUsers < ActiveRecord::Migration[6.0]
  BIO_DEFAULT = "This user hasn't updated their bio yet.".freeze

  def change
    change_column_default(:users, :bio, from: '', to: BIO_DEFAULT)
    
    User.where(bio: '').each { |u| u.update!(bio: BIO_DEFAULT) }
  end
end
