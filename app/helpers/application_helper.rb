module ApplicationHelper
  def current_top_menu(menu, status)
    # status(:active, :semi_active)
    @current_top_menu = {menu => status}
  end
  def top_menu_tag(menu)
    @links ||= {:dashboard => dashboard_path, :properties => dashboard_path}
    case @current_top_menu.try(:[], menu)
    when nil
      link_to(t("top_menu.#{menu.to_s}"), @links[menu], :class => "deactive")
    when :active
      content_tag :div, t("top_menu.#{menu.to_s}"), :class => "active"
    when :semi_active
      link_to(t("top_menu.#{menu.to_s}"), @links[menu], :class => "semiActive")
    end
  end
end
