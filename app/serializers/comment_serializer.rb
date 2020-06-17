class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :id, :body, :created_at, :user
  
  def created_at
    time_ago_in_words(object.created_at) + ' ago'
  end
end
