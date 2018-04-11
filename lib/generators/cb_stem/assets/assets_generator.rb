module CbStem

  module Generators

    # Generates CSS && JavaScript Assets
    class AssetsGenerator < Rails::Generators::Base

      source_root File.expand_path('templates', __dir__)

      def copy
        template(
          'active_admin.js.coffee',
          'app/assets/javascripts/active_admin.js.coffee',
          force: true
        )
        template(
          'active_admin.scss',
          'app/assets/stylesheets/active_admin.scss',
          force: true
        )
      end

    end

  end

end
