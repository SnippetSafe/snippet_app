class Language < ApplicationRecord
  validates_uniqueness_of :slug, :name
end