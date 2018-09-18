require 'rails/generators/active_record'

module WrapActiveadmin

  module Generators

    module Models

      # Generates Initializers
      class AdminUserGenerator < ActiveRecord::Generators::Base

        desc 'Installs WrapActiveadmin - AdminUser Module'
        source_root File.expand_path('../templates', __FILE__)

        argument :name, type: :string, default: 'AdminUser'

        def generate_admin
          template(
            'admin/admin_user.rb.erb',
            "app/admin/#{name.underscore}.rb"
          )
        end

        def generate_migrations
          migration_template(
            'migrate/add_fields_to_admin_users.rb.erb',
            "db/migrate/add_fields_to_#{name.underscore.pluralize}.rb"
          )
        end

        def generate_models
          template(
            'models/admin_user.rb.erb',
            "app/models/#{name.underscore}.rb"
          )
        end

        def gerenrate_decorators
          invoke 'wrap_activeadmin:decorators'
          template(
            'decorators/admin_user_decorator.rb.erb',
            'app/decorators/admin/admin_user_decorator.rb'
          )
        end

        def generate_seeds
          %w[
            admin_user
          ].each do |file|
            template(
              "seeds/#{file}.rb.erb",
              "db/seeds/wrap_activeadmin/#{file}.rb"
            )
          end
        end

      end

    end

  end

end
