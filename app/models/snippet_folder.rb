class SnippetFolder < ApplicationRecord
  belongs_to :snippet
  belongs_to :folder, counter_cache: :snippet_count
end
