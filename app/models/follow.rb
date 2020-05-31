class Follow < ApplicationRecord
  # The user being followed
  belongs_to :followed_user, foreign_key: :followed_user_id, class_name: 'User'

  # The user doing the following
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'

  validates_uniqueness_of :follower_id, scope: :followed_user_id
end
