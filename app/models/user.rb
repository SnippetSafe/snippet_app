class User < ApplicationRecord
  DEFAULT_FOLDER_NAME = 'My First Folder'.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :snippets
  has_many :comments
  has_many :likes
  has_many :folders
  has_many :all_snippets, through: :folders, source: :snippets
  has_many :languages, through: :snippets
  has_many :snippet_folders, through: :folders

  #TODO: Add tests for this
  after_create :create_default_folder

  private

  def create_default_folder
    folders.create!(name: DEFAULT_FOLDER_NAME)
  end
end
