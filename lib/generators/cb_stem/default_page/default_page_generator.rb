require 'rails/generators/active_record'

module CbStem

  module Generators

    # Install DefaultPage
    class DefaultPageGenerator < ActiveRecord::Generators::Base

      desc 'Installs CbStem - DefaultPage Module'
      argument :name, type: :string, default: 'DefaultPage'

      source_root File.expand_path('../templates', __FILE__)

      def generate_admin
        template 'admin/default_page.rb.erb', "app/admin/#{name.underscore}.rb"
      end

      def generate_decorators
        template 'decorators/default_page_decorator.rb.erb',
                 "app/decorators/#{name.underscore}_decorator.rb"
        template 'decorators/admin/default_page_decorator.rb.erb',
                 "app/decorators/admin/#{name.underscore}_decorator.rb"
      end

      def generate_models
        template 'models/default_page.rb.erb', "app/models/#{name.underscore}.rb"
      end

      def genrate_migrations
        migration_template 'migrate/create_default_pages.rb.erb',
                           "db/migrate/create_#{name.underscore.pluralize}.rb"
      end

    end

  end

end
