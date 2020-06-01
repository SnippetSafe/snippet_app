class SnippetFolder < ApplicationRecord
  belongs_to :snippet
  belongs_to :folder, counter_cache: :snippet_count

  # validates_uniqueness_of :folder_id, scope: :snippet_id
  validate :snippet_filed_already

  def snippet_filed_already
    user = Folder.find(folder_id).user

    if user.filed_snippets.find_by(id: snippet_id).present?
      errors.add(:snippet, 'already filed in a folder')
    end
  end
end
