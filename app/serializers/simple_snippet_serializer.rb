class SimpleSnippetSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :description,
    :highlighted,
    :language_label,
    :filename,
    :comments_count,
    :likes_count
  )

  has_one :user
end
