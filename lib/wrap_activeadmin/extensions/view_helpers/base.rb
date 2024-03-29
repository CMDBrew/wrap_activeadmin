module ViewHelpers

  # ViewHelpers Base
  module Base

    def aa_icon(icon, prefix: 'aa')
      return if icon.blank?
      content_tag(:i, '', class: "#{prefix}-icon #{prefix}-#{icon}")
    end

    private

    def bs_class_for(type)
      {
        success: 'alert-success',
        error: 'alert-danger',
        alert: 'alert-warning',
        notice: 'alert-info'
      }[type.to_sym] || type.to_s
    end

  end

end
