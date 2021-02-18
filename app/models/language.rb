class Language < ApplicationRecord
  validates_uniqueness_of :name
end