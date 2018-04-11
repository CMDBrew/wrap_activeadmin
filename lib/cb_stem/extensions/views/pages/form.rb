module ActiveAdmin

  module Views

    module Pages

      # Overwriting Form activeadmin/lib/active_admin/views/pages/form.rb
      class Form < Base

        def form_presenter
          active_admin_config.get_page_presenter(:form) || default_form_config
        end

        # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        def main_content
          options = default_form_options.merge form_presenter.options

          # rubocop:disable Metrics/LineLength
          options[:multiple] &&
            ActiveSupport::Deprecation.
              warn("'multiple' is deprecated and will be removed in the stable release please change to 'plain' instead")
          # rubocop:enable Metrics/LineLength

          if options[:partial]
            render options[:partial]
          elsif options[:multiple] || options[:plain]
            instance_exec(&form_presenter.block)
          else
            active_admin_form_for resource, options, &form_presenter.block
          end
        end

        alias form_section active_admin_form_for

      end

    end

  end

end
