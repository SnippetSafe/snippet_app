class SimpleSnippetSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :description,
    :highlighted_body,
    :body,
    :language,
    :comments_count,
    :likes_count,
    :liked_by_current_user
  )

  has_one :user

  def liked_by_current_user
    current_user ? object.liked_by?(current_user) : false
  end

  private

  def current_user
    scope
  end
end
