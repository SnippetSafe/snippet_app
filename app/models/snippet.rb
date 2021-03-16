class Snippet < ApplicationRecord
  extend FriendlyId
  friendly_id :description, use: :slugged

  has_many :snippet_folders, dependent: :destroy
  has_many :folders, through: :snippet_folders
  belongs_to :user, required: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :language, required: true

  validates_presence_of :body
  validates_presence_of :description
  validate :owner_folder_presence

  attr_accessor :folder_id

  scope :public_snippets, -> { where(public: true) }
  scope :private_snippets, -> { where(public: false) }
  scope :popular, -> { order(likes_count: :desc) }

  def folder_for_user(user)
    folders.find_by(user_id: user&.id)
  end

  def comments_count
    comments.size
  end

  def likes_count
    likes.size
  end

  def liked_by?(user)
    likes.find_by_user_id(user&.id).present?
  end

  # TODO: Prevent needing to do on the fly by saving to db
  def preview
   @preview ||=  body.split("\n").first(15).join("\n")
  end

  def has_preview?
    preview != body
  end

  def client_id
    "snippet_#{id}"
  end

  def private?
    !public?
  end

  def visible_to?(user)
    if private?
      self.user_id == user.try(:id)
    else
      true
    end
  end

  def comments?
    comments_count > 0
  end

  def likes?
    likes_count > 0
  end

  private

  def owner_folder_presence
    errors.add(:folder, 'must exist') if owner_folder_removed?
  end

  #it would be really nice to do this without in memory iteration
  def owner_folder_removed?
    folders.none? { |f| f.user_id == user_id }
  end
end
