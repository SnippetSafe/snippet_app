class Comment < ApplicationRecord
  belongs_to :snippet, counter_cache: true
  belongs_to :user

  validates_presence_of :body

  def serialize
    CommentSerializer.new(self).to_h
  end

  def user_name
    user.name
  end
end
