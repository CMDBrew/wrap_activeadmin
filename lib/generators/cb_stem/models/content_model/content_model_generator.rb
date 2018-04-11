require 'rails/generators/active_record'

module CbStem

  module Generators

    module Models

      # Generates ContentModel
      class ContentModelGenerator < Rails::Generators::Base

        include Rails::Generators::Migration

        desc 'Installs CbStem - ContentModel Module'
        source_root File.expand_path('templates', __dir__)

        def self.next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          ActiveRecord::Migration.next_migration_number(next_migration_number)
        end

        def generate_migrations
          %w[
            content_model_configs content_configs
            input_group_configs input_configs
          ].each do |file|
            migration_template(
              "migrate/create_#{file}.rb.erb",
              "db/migrate/create_#{file}.rb"
            )
          end
        end

      end

    end

  end

end
