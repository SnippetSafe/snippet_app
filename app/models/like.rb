class Like < ApplicationRecord
  belongs_to :snippets, counter_cache: true
  belongs_to :user
end
