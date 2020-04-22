class Comment < ApplicationRecord
  belongs_to :snippet, counter_cache: true
  belongs_to :user

  def user_name
    user.name
  end
end
