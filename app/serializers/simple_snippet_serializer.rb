class SimpleSnippetSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :description,
    :highlighted,
    :language_label,
    :filename,
    :comments_count,
    :likes_count,
    :liked_by_current_user
  )

  has_one :user
  has_one :language

  def liked_by_current_user
    object.liked_by?(current_user)
  end

  private

  def current_user
    scope
  end
end
