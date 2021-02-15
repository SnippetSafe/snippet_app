class Snippet < ApplicationRecord
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

  def folder_for_user(user)
    folders.find_by(user_id: user&.id)
  end

  # TODO: Don't call serializers from model - just instantiate in controller
  def serializable(current_user)
    SnippetSerializer.new(self, scope: current_user)
  end

  def serialize(current_user)
    serializable(current_user).to_h
  end

  def simple_serializable(current_user)
    SimpleSnippetSerializer.new(self, scope: current_user)
  end

  def simple_serialize(current_user)
    simple_serializable(current_user).to_h
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

  def language_label
    "<span style='border-radius: 5px; position: absolute; top: -13px; right: 25px; border: 1px solid lightgrey; font-family: monospace; padding: 4px 28px 4px 10px; background-color: snow;'><i style='position: absolute; right: 7px;' class='devicon-ruby-plain colored'></i>#{ language.name }</span>"
  end

  # Prevent needing to do on the fly by saving to db
  def preview
    body.split("\n").first(15).join("\n")
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

  private

  def owner_folder_presence
    errors.add(:folder, 'must exist') if owner_folder_removed?
  end

  #it would be really nice to do this without in memory iteration
  def owner_folder_removed?
    folders.none? { |f| f.user_id == user_id }
  end
end
