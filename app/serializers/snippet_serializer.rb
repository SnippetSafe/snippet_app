class SnippetSerializer < ActiveModel::Serializer
  attributes :id, :description, :highlighted, :language_label, :filename
end
