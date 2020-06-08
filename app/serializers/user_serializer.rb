class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :snippets_count, :followers_count, :following_count
end
