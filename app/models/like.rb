class Like < ApplicationRecord
  belongs_to :snippet, counter_cache: true
  belongs_to :user

  def self.toggle(user_id, snippet_id)
    like = Like.find_or_initialize_by(user_id: user_id, snippet_id: snippet_id)
    like.persisted? ? like.destroy : like.tap(&:save!)
  end
end
