class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :snippet_count

  has_many :snippets
end
