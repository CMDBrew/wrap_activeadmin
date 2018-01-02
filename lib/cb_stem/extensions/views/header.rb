module ActiveAdmin

  module Views

    # Overwriting Header Component - activeadmin/lib/active_admin/views/header.rb
    class Header < Component

      def tag_name
        :nav
      end

      def build(namespace, menu)
        super(id: 'header', class: 'navbar navbar-default')

        @namespace = namespace
        @menu = menu
        @utility_menu = @namespace.fetch_menu(:utility_navigation)

        build_site_title
        build_global_navigation
        build_utility_navigation
      end

      def build_site_title
        insert_tag(
          view_factory.site_title,
          @namespace
        )
      end

      def build_global_navigation
        insert_tag(
          view_factory.global_navigation,
          @menu,
          id: 'main-nav',
          class: 'nav navbar-nav navbar-left'
        )
      end

      def build_utility_navigation
        insert_tag(
          view_factory.utility_navigation,
          @utility_menu,
          id: 'utility-nav',
          class: 'nav navbar-nav navbar-right'
        )
      end

    end

  end

end
