require 'devise'
require 'bootstrap'
require 'bootstrap-datepicker-rails'
require 'active_admin'
require 'draper'
require 'carrierwave'

module CbStem

  # Initialize Engine
  # rubocop:disable Metrics/ClassLength
  class Engine < ::Rails::Engine

    isolate_namespace CbStem

    ActiveAdmin.before_load do |app|
      require_relative 'extensions/batch_actions/views/batch_action_selector'
      app.view_factory.register batch_action_selector:
        ::ActiveAdmin::BatchActions::BatchActionSelector
    end

    initializer 'default configs' do |_app|
      ActiveAdmin.setup do |config|
        config.current_filters = false
        config.comments_menu   = false
      end
    end

    initializer 'assets precompile' do |_app|
      config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    end

    initializer 'view overrides' do |_app|
      require_helpers
      require_formtastic
      require_resources
      require_components
      require_inputs
      require_views
      require_pages
      require_others
    end

    initializer 'cb_stem.assets.precompile' do |app|
      app.config.assets.precompile += %w[
        cb_stem/logo.png cb_stem/empty_state.svg
        cb_stem/default/avatar.png
      ]
    end

    config.to_prepare do
      Dir.glob(Rails.root + 'app/admin/concerns/**/*.rb').each do |c|
        require_dependency(c)
      end
    end

    private

    def require_others
      require_each(
        %w[view_factory form_builder]
      )
    end

    def require_formtastic
      require_each(
        %w[
          base/wrapping base/html base/labelling actions/base
          inputs/boolean_input inputs/switch_input inputs/file_input
          helpers/errors_helper
          form_builder
        ],
        path: 'formtastic'
      )
    end

    def require_components
      require_each(
        %w[
          site_title table_for dropdown_menu panel attributes_table
          active_admin_form blank_slate columns scopes tabs
        ],
        path: 'views/components'
      )
    end

    def require_resources
      require_each(
        %w[action_items],
        path: 'resource'
      )
    end

    def require_helpers
      require_each(
        %w[view_helpers],
        path: 'views/helpers'
      )
    end

    def require_views
      require_each(
        %w[
          action_items header tabbed_navigation
          title_bar index_as_table footer
        ],
        path: 'views'
      )
    end

    def require_pages
      require_each(
        %w[base index form],
        path: 'views/pages'
      )
    end

    def require_inputs
      require_each(
        %w[base/search_method_select date_range_input forms],
        path: 'inputs/filters'
      )
    end

    def require_each(files, path: nil)
      file_path = ['extensions/', path].reject(&:blank?).join('/')
      files.each do |x|
        require_relative "#{file_path}/#{x}"
      end
    end

  end

end
