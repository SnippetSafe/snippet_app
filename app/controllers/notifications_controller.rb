class NotificationsController < ApplicationController
  after_action -> { current_user.mark_notifications_as_read }, only: :index

  def index
    @page_title = 'Notifications'
    @notifications = current_user.notifications.order(created_at: :desc)
  end
end
