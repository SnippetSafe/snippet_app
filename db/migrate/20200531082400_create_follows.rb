class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.integer :followed_user_id, foreign_key: { to_table: :users }
      t.integer :follower_id, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
