class Like < ApplicationRecord
  belongs_to :snippet, counter_cache: true
  belongs_to :user
  has_many :notifications, as: :notifiable, dependent: :destroy

  def self.toggle(user_id, snippet_id)
    like = Like.find_or_initialize_by(user_id: user_id, snippet_id: snippet_id)

    if like.persisted?
      like.destroy
    else
      like.save!

      unless user_id.to_i == like.snippet.user_id
        like.notifications.create!(user_id: like.snippet.user_id)
      end
    end
  end
end
