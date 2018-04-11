require 'rails/generators/active_record'

module CbStem

  module Generators

    # Generates Initializers
    class InitializersGenerator < ActiveRecord::Generators::Base

      source_root File.expand_path('templates', __dir__)

      argument :name, type: :string, default: 'AdminUser'

      def setup_directory
        empty_directory 'config/initializers/cb_stem'
      end

      def generate_configs
        template(
          'cb_stem/menu.rb.erb',
          'config/initializers/cb_stem/menu.rb'
        )
        template(
          'cb_stem/menu.rb.erb',
          'config/initializers/cb_stem/config.rb'
        )
      end

      def generate_kaminari_patch
        template(
          'cb_stem/kaminari.rb.erb',
          'config/initializers/cb_stem/kaminari.rb'
        )
      end

      def generate_fog
        template(
          'fog.rb.erb',
          'config/initializers/fog.rb'
        )
      end

    end

  end

end
