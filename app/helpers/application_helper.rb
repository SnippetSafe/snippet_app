module ApplicationHelper
  def tabs_class_for_active_tab(tab_id, param_tab_id)
    "tabs--header-active" if tab_id.to_sym == param_tab_id.to_sym
  end

  def tabs_details_class_for_active_tab(tab_id, param_tab_id)
    "hidden" unless tab_id.to_sym == param_tab_id.to_sym
  end
end
