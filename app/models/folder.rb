class Folder < ApplicationRecord
  belongs_to :user, required: true
  has_many :snippet_folders, dependent: :destroy
  has_many :snippets, through: :snippet_folders
end
