class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :bio,
    :location,
    :snippets_count,
    :followers_count,
    :following_count,
    :avatar_url
  )
end
