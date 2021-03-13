class Language < ApplicationRecord
  validates_uniqueness_of :name

  def mime_type
    mime_types.first
  end

  def extension
    extensions.first
  end
end