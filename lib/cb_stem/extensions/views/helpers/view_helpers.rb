# Extend ActiveAdmin ViewHelpers
module ActiveAdmin::ViewHelpers

  def menu_label(label, icon: nil, badge: 0)
    safe_join [
      aa_icon(icon),
      menu_title(label),
      menu_badge(badge)
    ]
  end

  def flashes_html
    flash.each do |type, msg|
      concat(content_tag(:div, msg, class: "alert #{bs_class_for(type)}"))
    end
    nil
  end

  def devise_error_messages!
    return '' unless devise_error_messages?
    devise_error_html&.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

  def thumbnail(*args)
    options = args.extract_options!
    klass   = options.delete(:class)
    content_tag :div, class: "thumbnail #{klass}" do
      image_tag(*args)
    end
  end

  private

  def aa_icon(icon)
    return if icon.blank?
    content_tag(:i, '', class: "nc-icon nc-#{icon}")
  end

  def menu_title(label)
    content_tag(:span, label, class: 'menu-text')
  end

  def menu_badge(badge)
    return unless badge.is_a?(Integer) && badge.positive?
    badge = '99+' if badge > 99
    content_tag(:span, badge, class: 'badge badge-pill badge-success')
  end

  def devise_error_html
    messages = resource.errors.full_messages.join(', ')
    <<-HTML
    <div class='alert alert-danger'>
      #{messages}
    </div>
    HTML
  end

  def bs_class_for(type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[type.to_sym] || type.to_s
  end

end
