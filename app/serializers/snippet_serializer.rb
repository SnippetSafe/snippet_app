class SnippetSerializer < ActiveModel::Serializer
  has_one :user
  attributes :id, :description, :highlighted, :language_label, :filename
end
