class SnippetSerializer < ActiveModel::Serializer
  attributes :id, :description, :highlighted, :language_label
end
