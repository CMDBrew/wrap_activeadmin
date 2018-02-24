module ActiveAdmin

  module Views

    # Build a Blank Slate
    class BlankSlate < ActiveAdmin::Component

      builder_method :blank_slate

      def default_class_name
        'blank_slate_container'
      end

      def build(content)
        super(safe_join([
          blank_slate_icon,
          blank_slate_content(content)
        ].compact))
      end

      private

      def blank_slate_icon
        image_tag('cb_stem/empty_state.svg', retina: true)
      end

      def blank_slate_content(content)
        h4 content&.html_safe, class: 'blank_slate display-4'
      end

    end

  end

end
