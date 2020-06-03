class SimpleSnippetSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes(
    :id,
    :description,
    :highlighted_body,
    :body,
    :language,
    :comments_count,
    :likes_count,
    :liked_by_current_user,
    :created_at
  )

  has_one :user

  def liked_by_current_user
    current_user ? object.liked_by?(current_user) : false
  end

  def created_at
    time_ago_in_words(object.created_at) + ' ago'
  end

  private

  def current_user
    scope
  end
end
