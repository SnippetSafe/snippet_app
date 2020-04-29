class Snippet < ApplicationRecord
  has_and_belongs_to_many :folders
  belongs_to :user, required: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

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
    likes.find_by_user_id(user.id).present?
  end

  def language_label
    "<span style='border-radius: 5px; position: absolute; top: -13px; right: 25px; border: 1px solid lightgrey; font-family: monospace; padding: 4px 28px 4px 10px; background-color: snow;'><i style='position: absolute; right: 7px;' class='devicon-ruby-plain colored'></i>#{ language.name }</span>"
  end

  def highlighted
    Pygments.highlight(
      body,
      lexer: language.lexer_alias,
      options: { encoding: 'utf-8', linenos: false }
    ).html_safe
  end
end
