class User < ApplicationRecord
  DEFAULT_FOLDER_NAME = 'My First Folder'.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

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

  has_many :snippets
  has_many :filed_snippets, through: :folders, source: :snippets
  has_many :followed_snippets, through: :following, source: :snippets

  has_many :comments
  has_many :likes
  has_many :languages, through: :snippets

  #TODO: Add tests for this
  after_create :create_default_folder

  def follow(user)
    Follow.create(followed_user_id: user.id, follower_id: id)
  end

  def unfollow(user)
    follow = Follow.find_by(followed_user_id: user.id, follower_id: id)

    raise 'You do not follow this person' unless follow.present?

    follow.destroy!
  end

  def following?(user)
    following.find_by(id: user.id).present?
  end

  # TODO: Use cache counter instead of this
  def followers_count
    followers.size
  end

  # TODO: Use cache counter instead of this
  def snippets_count
    snippets.size
  end

  def serialize
    UserSerializer.new(self).to_h
  end

  def snippets_for_feed
    snippet_ids = followed_snippets.pluck(:id).concat(snippets.pluck(:id))

    Snippet.where(id: snippet_ids).order(created_at: :desc)
  end

  private

  def create_default_folder
    folders.create!(name: DEFAULT_FOLDER_NAME)
  end
end
