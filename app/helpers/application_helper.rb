module ApplicationHelper
  def tabs_class_for_active_tab(tab_id, param_tab_id)
    "tabs--header-active" if tab_id.to_sym == param_tab_id.to_sym
  end

  def tabs_details_class_for_active_tab(tab_id, param_tab_id)
    "hidden" unless tab_id.to_sym == param_tab_id.to_sym
  end

  def notification_counter(user)
    count = current_user.notifications.unread.size

    if count > 0
      count_for_display = count > 9 ? 9 : count

      "<span class='menu-button--notification'>#{count_for_display}</span>".html_safe
    end
  end

  def notification_for_display(notification)
    case notification.notifiable_type
    when 'Follow'
      render partial: 'notifications/follow', locals: { notification: notification }
    end
  end
end
