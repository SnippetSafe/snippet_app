class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :snippet_count, :recent_snippets

  def recent_snippets
    object.snippets.order(created_at: :desc).limit(3)
  end
end
