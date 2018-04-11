require 'rails/generators/active_record'

module CbStem

  module Generators

    # Generates Tasks
    class TasksGenerator < Rails::Generators::Base

      source_root File.expand_path('templates', __dir__)

      def setup_directory
        empty_directory 'db/cb_stem/seeds'
      end

      def generate_tasks
        template(
          'cb_stem/seed.rake.erb',
          'lib/tasks/cb_stem/seed.rake',
          force: true
        )
      end

    end

  end

end
