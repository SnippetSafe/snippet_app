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

  def notification_action_text(notification)
    case notification.notifiable_type
    when 'Follow'
      'followed you'
    when 'Comment'
      'commented on your snippet'
    when 'SnippetFolder'
      'filed your snippet'
    end
  end

  def nav_item(path, icon)
    active = path == request.path

    color = active ? 'primary' : 'black'
    css_class = active ? 'active' : 'inactive'

    link_to(path) do
      image_tag("/icons/#{color}/#{icon}.svg", width: 24, class: "nav-item--#{css_class}")
    end
  end

  def profile_nav_item
    profile_path = user_path(current_user)

    css_class = request.path == profile_path ? 'active' : 'inactive'
    link_to(profile_path) do
      image_tag current_user.avatar_url, class: "profile-nav-item--#{css_class}"
    end
  end
end
