require 'rails/generators/active_record'
require 'cb_stem/generators/helper'

module CbStem

  module Generators

    # Generates Decorators
    class DecoratorsGenerator < Rails::Generators::Base

      include ::CbStem::Generators::Helper

      source_root File.expand_path('templates', __dir__)

      def generate_decorators
        template(
          'application_decorator.rb.erb',
          'app/decorators/application_decorator.rb'
        )
      end

    end

  end

end
