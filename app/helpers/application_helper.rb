module ApplicationHelper
  include Pagy::Frontend

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

  def profile_nav_item
    profile_path = user_path(current_user)

    css_class = request.path == profile_path ? 'active' : 'inactive'
    link_to(profile_path) do
      image_tag current_user.avatar_url, class: "profile-nav-item--#{css_class}"
    end
  end

  def new_snippet_folder_id
    params[:id] if controller.is_a?(FoldersController)
  end

  def color_for_like_status(snippet)
    snippet.liked_by?(current_user) ? 'text-red-500' : 'text-gray-500'
  end

  def color_class_for_notification_icon(icon)
    case icon
    when 'heart'
      'text-red-500'
    when 'folder'
      'text-yellow-500'
    when 'user'
      'text-pink-500'
    when 'chat'
      'text-purple-500'
    end
  end
end
