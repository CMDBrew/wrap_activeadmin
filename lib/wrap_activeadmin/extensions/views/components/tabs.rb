module ActiveAdmin

  module Views

    # Register Tabs in Views
    class Tabs < ActiveAdmin::Component

      builder_method :tabs

      def tab(title, options = {}, &block)
        title = title.to_s.titleize if title.is_a? Symbol
        @menu << build_menu_item(title, options, &block)
        @tabs_content << build_content_item(title, options, &block)
      end

      def build(jquery: true)
        add_class 'disable-jquery-ui-tabs' unless jquery
        @menu = ul(class: 'nav nav-tabs', role: 'tablist')
        @tabs_content = div(class: 'tab-content')
      end

      def build_menu_item(title, options)
        options = options.reverse_merge({})
        klass   = %w[nav-item]
        klass.push options.delete(:class)
        li class: klass.join(' ') do
          link_to title, "##{title.parameterize}", options
        end
      end

      def build_content_item(title, options, &block)
        options = options.reverse_merge(id: title.parameterize)
        div(options, &block)
      end

    end

  end

end
