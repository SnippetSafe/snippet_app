class SnippetSerializer < ActiveModel::Serializer
  has_one :user
  has_many :comments

  attributes(
    :id,
    :description,
    :body,
    :highlighted_body,
    :language,
    :comments_count,
    :likes_count,
    :liked_by_current_user
  )

  def liked_by_current_user
    object.liked_by?(current_user)
  end

  private

  def current_user
    scope
  end
end
