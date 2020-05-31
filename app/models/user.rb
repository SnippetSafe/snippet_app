class User < ApplicationRecord
  DEFAULT_FOLDER_NAME = 'My First Folder'.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :snippets
  has_many :all_snippets, through: :folders, source: :snippets

  has_many :folders
  has_many :snippet_folders, through: :folders

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower
  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  
  # returns an array of other users who the user has followed
  has_many :following, through: :given_follows, source: :followed_user

  has_many :comments
  has_many :likes
  has_many :languages, through: :snippets

  #TODO: Add tests for this
  after_create :create_default_folder

  private

  def create_default_folder
    folders.create!(name: DEFAULT_FOLDER_NAME)
  end
end
