class SnippetSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  has_one :user
  has_many :comments

  attributes(
    :id,
    :description,
    :body,
    :highlighted_body,
    :language,
    :comments_count,
    :likes_count,
    :liked_by_current_user,
    :created_at,
    :updated_at
  )

  def liked_by_current_user
    current_user ? object.liked_by?(current_user) : false
  end

  def created_at
    time_ago_in_words(object.created_at) + ' ago'
  end

  def updated_at
    time_ago_in_words(object.updated_at) + ' ago'
  end

  private

  def current_user
    scope
  end
end
