class Folder < ApplicationRecord
  belongs_to :user, required: true
  has_and_belongs_to_many :snippets
end
