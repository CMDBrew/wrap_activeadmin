require 'rails/generators/active_record'
require 'cb_stem/generators/helper'

module CbStem

  module Generators

    # Install Gem
    class InstallGenerator < ActiveRecord::Generators::Base

      include ::CbStem::Generators::Helper

      desc 'Installs CbStem and generates the necessary migrations & overwrites'
      source_root File.expand_path('templates', __dir__)

      argument :name, type: :string, default: 'AdminUser'
      class_option :skip_activeadmin, type: :string, default: true, alias: :aa

      def revert_devise
        case behavior
        when :revoke
          %w[
            config/initializers/devise.rb
            config/locales/devise.en.yml
          ].each do |file|
            remove_file(file)
          end
        end
      end

      def install_active_admin
        return if options[:skip_activeadmin]
        invoke 'active_admin:install', [name]
      end

      def install_configs
        invoke 'cb_stem:assets'
        invoke 'cb_stem:initializers'
        invoke 'cb_stem:models:admin_user'
        invoke 'cb_stem:uploaders'
        invoke 'cb_stem:tasks'
      end

      def install_decorators
        invoke 'cb_stem:decorators'
      end

      def remove_unused_files
        %w[
          app/admin/dashboard.rb
        ].each do |file|
          remove_file file
        end
      end

    end

  end

end
