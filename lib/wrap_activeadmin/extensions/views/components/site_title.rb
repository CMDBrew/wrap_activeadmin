module ActiveAdmin

  module Views

    # Overwriting SiteTitle Component - activeadmin/lib/active_admin/views/components/site_title.rb
    class SiteTitle < Component

      def tag_name
        :div
      end

      def build(namespace)
        super(class: 'navbar')
        @namespace = namespace

        div class: 'navbar-brand' do
          site_title_content
        end
      end

      private

      def site_title_image
        div class: 'logo' do
          if site_title_image?
            title_image
          else
            div(title_text.split(' ').map(&:first)[0..1].join(''), class: 'placeholder')
          end
        end
      end

      def site_link
        return unless site_title_link?
        a(href: @namespace.site_title_link,
          id: 'site-link', title: I18n.t('active_admin.view_site_link'),
          class: 'btn btn-link',
          target: '_blank') do
          div(class: 'tooltip-holder', title: I18n.t('active_admin.view_site_link'),
              'data-toggle': 'tooltip', 'data-placement': 'bottom')
          i('', class: 'aa-icon aa-launch-site')
        end
      end

      def close_link
        div title: I18n.t('active_admin.header_close') do
          a(class: 'btn btn-link d-xl-none',
            target: '_blank', 'data-toggle': 'collapse', 'data-target': '#header') do
            div(class: 'tooltip-holder', title: I18n.t('active_admin.header_close'),
                'data-toggle': 'tooltip', 'data-placement': 'bottom')
            i('', class: 'aa-icon aa-close-sidebar')
          end
        end
      end

      def site_title_content
        site_title_image
        div class: 'title-text text-truncate' do
          text_node title_text
        end
        site_link
        close_link
      end

    end

  end

end