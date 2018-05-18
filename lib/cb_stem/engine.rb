# Base
require 'devise'
require 'active_admin'
require 'draper'
require 'ancestry'
require 'acts_as_list'
# Components
require 'bootstrap'
require 'bootstrap-datepicker-rails'
require 'jquery-minicolors-rails'
require 'just-datetime-picker'
require 'carrierwave'
require 'carrierwave/video'
require 'carrierwave/audio'
require 'streamio-ffmpeg'
require 'tinymce-rails'
require 'select2-rails'
require 'dropzonejs-rails'
require 'chart-js-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
# Countries
require 'flag-icons-rails'
require 'carmen-rails'
require 'countries'
# Google Analytics
require 'oauth2'
require 'legato'
require 'signet/oauth_2/client'

# CbStem
module CbStem

  # Initialize Engine
  # rubocop:disable Metrics/ClassLength
  class Engine < ::Rails::Engine

    isolate_namespace CbStem

    config.autoload_paths += Dir[CbStem::Engine.root.join('app', 'uploaders', '*').to_s]

    ActiveAdmin.before_load do |app|
      require_relative 'extensions/batch_actions/controller'
      require_relative 'extensions/batch_actions/resource_extension'
      require_relative 'extensions/batch_actions/views/batch_action_selector'
      app.view_factory.register batch_action_selector:
        ::ActiveAdmin::BatchActions::BatchActionSelector
    end

    config.to_prepare do
      Dir.glob(CbStem::Engine.root + 'app/admin/concerns/cb_stem/**/*_feature*.rb').each do |c|
        require_dependency(c)
      end
    end

    config.to_prepare do
      Dir.glob(CbStem::Engine.root + 'app/decorators/cb_stem/**/*_decorator*.rb').each do |c|
        require_dependency(c)
      end
    end

    initializer :cb_stem do
      if defined?(ActiveAdmin)
        ::ActiveAdmin.application.load_paths.unshift root.join('lib', 'cb_stem/admin').to_s
      end
    end

    initializer 'default configs' do |_app|
      ActiveAdmin.setup do |config|
        config.current_filters = false
        config.comments_menu   = false
        config.meta_tags = {
          viewport: 'width=device-width, height=device-height, initial-scale=1.0, user-scalable=no'
        }
      end
    end

    initializer 'assets precompile' do |_app|
      config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    end

    initializer 'view overrides' do |_app|
      require_view_helpers
      require_formtastic
      require_just_datetime_picker
      require_filters
      require_resources
      require_dsls
      require_components
      require_inputs
      require_views
      require_orm
      require_pages
      require_others
    end

    initializer 'initialize DSL' do |_app|
      ::ActiveAdmin::DSL.send(:include, ActiveAdmin::HtmlContents::DSL)
    end

    initializer 'cb_stem.assets.precompile' do |app|
      app.config.assets.precompile += %w[
        cb_stem/logo.png cb_stem/default/avatar.png cb_stem/default/media.png
        cb_stem/empty_state.svg cb_stem/sortable_handle.svg
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
        %w[
          base_controller view_factory form_builder
          html_content resource page
        ]
      )
    end

    def require_formtastic
      require_each(
        %w[
          base/wrapping base/html base/labelling actions/base
          inputs/boolean_input inputs/switch_input inputs/file_input
          inputs/select_input inputs/color_picker_input inputs/hstore_input
          inputs/date_picker_input inputs/base/timeish helpers/errors_helper
          form_builder
        ],
        path: 'formtastic'
      )
    end

    def require_just_datetime_picker
      require_each(
        %w[just_datetime_picker],
        path: 'just_datetime_picker'
      )
    end

    def require_components
      require_each(
        %w[
          site_title table_for dropdown_menu panel attributes_table
          active_admin_form blank_slate columns scopes tabs
          cb_stem_component chart html_content notification_messages
        ],
        path: 'views/components'
      )
    end

    def require_filters
      require_each(
        %w[resource_extension],
        path: 'filters'
      )
    end

    def require_resources
      require_each(
        %w[action_items html_contents],
        path: 'resource'
      )
    end

    def require_view_helpers
      require_each(%w[view_helpers])
    end

    def require_orm
      require_each(
        %w[active_admin_comments],
        path: 'orm/active_record/comments/views'
      )
    end

    def require_views
      require_each(
        %w[
          action_items header tabbed_navigation
          title_bar index_as_table footer sidebar_section
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

    def require_dsls
      require_each(
        %w[html_contents],
        path: 'dsl'
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
