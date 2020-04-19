class SnippetSerializer < ActiveModel::Serializer
  has_one :user
  has_many :comments
  attributes :id, :description, :highlighted, :language_label, :filename
end
