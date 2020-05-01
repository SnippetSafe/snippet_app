class Comment < ApplicationRecord
  belongs_to :snippet, counter_cache: true
  belongs_to :user

  validates_presence_of :body

  def user_name
    user.name
  end
end
