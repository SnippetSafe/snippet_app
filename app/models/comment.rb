class Comment < ApplicationRecord
  belongs_to :snippet
  belongs_to :user

  def user_name
    user.name
  end
end
