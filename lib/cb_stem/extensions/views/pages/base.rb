module ActiveAdmin

  module Views

    module Pages

      # Overwriting Header - activeadmin/lib/active_admin/views/pages/base.rb
      # rubocop:disable Metrics/ClassLength
      class Base < Arbre::HTML::Document

        WRAPPER_CLASS = 'container-fluid'.freeze

        def build(*args)
          super
          add_classes_to_body
          build_active_admin_head
          build_page
        end

        def build_page
          within @body do
            headers
            div id: 'wrapper', class: WRAPPER_CLASS do
              build_unsupported_browser
              build_title_bar
              build_page_content
            end
            footers
          end
        end

        def loading_backdrop
          div id: 'loading-backdrop' do
            div class: 'backdrop'
            div class: 'lds-ring'
          end
        end

        def headers
          build_header
          build_flash_messages
        end

        def footers
          loading_backdrop
          # build_float_help
        end

        def build_float_help
          div id: 'float-help' do
            i class: 'nc-icon'
            span 'Need Help?'
          end
        end

        def build_flash_messages
          div id: 'flash-wrapper' do
            notification_messages(flash_messages)
          end
        end

        def build_page_content
          div id: 'active_admin_content',
              class: (skip_sidebar? ? 'without_sidebar' : 'with_sidebar') do
            build_main_content_wrapper
            build_sidebar unless skip_sidebar?
          end
          build_html_contents unless skip_html_contents?
        end

        private

        def skip_sidebar?
          sidebar_sections_for_action.reject { |x| x.name == 'filters' }.empty? ||
            assigns[:skip_sidebar] == true
        end

        def valid_links
          return if links.blank?
          links.delete_if { |x| x =~ %r{<a\ href="\/admin">Admin<\/a>} }
        end

        def breadcrumbs?
          valid_links.present? && links.is_a?(::Array)
        end

        def build_breadcrumb(separator = '/')
          return unless breadcrumbs?
          ul id: 'breadcrumbs', class: 'list-inline mb-3' do
            valid_links.each do |link|
              li class: 'list-inline-item mr-1 my-1' do
                text_node(link)
                span(separator, class: 'breadcrumb_sep ml-1 text-muted')
              end
            end
            li(text_node(title), class: 'list-inline-item mr-1')
          end
        end

        def links
          breadcrumb_config = active_admin_config&.breadcrumb
          if breadcrumb_config.is_a?(Proc)
            instance_exec(controller, &active_admin_config.breadcrumb)
          elsif breadcrumb_config.present?
            breadcrumb_links
          end
        end

        def build_main_content_wrapper
          div id: 'main_content_wrapper' do
            div id: 'main_content' do
              build_breadcrumb
              main_content
            end
            build_footer
          end
        end

        # Extra Section
        def html_contents_for_action
          if active_admin_config&.html_contents?
            active_admin_config.html_contents_for(params[:action], self)
          else
            []
          end
        end

        def build_html_contents
          div id: 'html_contents' do
            html_contents_for_action.collect do |section|
              html_content(section)
            end
          end
        end

        def skip_html_contents?
          html_contents_for_action.empty? || assigns[:skip_html_contents] == true
        end

      end

    end

  end

end
