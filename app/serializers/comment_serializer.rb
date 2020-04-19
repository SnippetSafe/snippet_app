class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :user_name
  
  belongs_to :user
end
