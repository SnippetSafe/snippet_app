class SnippetFolder < ApplicationRecord
  belongs_to :snippet
  belongs_to :folder, counter_cache: :snippet_count
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates_uniqueness_of :folder_id, scope: :snippet_id
end
