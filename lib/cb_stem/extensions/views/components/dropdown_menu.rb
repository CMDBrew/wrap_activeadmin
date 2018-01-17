module ActiveAdmin

  module Views

    # Overwriting DropdownMenu - activeadmin/lib/active_admin/views/components/dropdown_menu.rb
    class DropdownMenu < ActiveAdmin::Component

      WRAPPER_CLASS = 'dropdown'.freeze
      TOGGLE_CLASS  = 'btn btn-secondary btn-sm dropdown-toggle'.freeze
      MENU_CLASS    = 'dropdown-menu'.freeze
      ITEM_CLASS    = 'dropdown-item'.freeze

      def build(name, options = {})
        options = options.dup

        # Easily set options for the button or menu
        button_options = options.delete(:button) || {}
        menu_options = options.delete(:menu) || {}

        @button = build_button(name, button_options)
        @menu = build_menu(menu_options)

        super(options.merge(class: WRAPPER_CLASS))
      end

      def item(*args)
        within @menu do
          li build_link(*args)
        end
      end

      private

      def build_link(*args)
        args.map! do |x|
          x[:class] += ITEM_CLASS if x.is_a? Hash
          x
        end
        link_to(*args)
      end

      def build_button(name, button_options)
        button_options[:class] ||= ''
        button_options[:class] << " #{TOGGLE_CLASS}"
        button_options['data-toggle'] = 'dropdown'

        button_options[:href] = '#'

        a button_options do
          text_node(name)
        end
      end

      def build_menu(options)
        options[:class] ||= ''
        options[:class] << " #{MENU_CLASS}"

        menu_list = ul(options)
        menu_list
      end

    end

  end

end
