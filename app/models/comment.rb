class Comment < ApplicationRecord
  belongs_to :snippet, counter_cache: true
  belongs_to :user

  validates_presence_of :body

  def created_by?(comparison_user)
    user.id == comparison_user.id
  end

  def serialize
    CommentSerializer.new(self).to_h
  end

  def user_name
    user.name
  end

  def popover_options_for(user)
    options = []

    options << { type: :alert, title: 'Delete', url: delete_alert_comment_path(self) }

    options
  end

  def client_id
    "comment_#{id}"
  end
end
