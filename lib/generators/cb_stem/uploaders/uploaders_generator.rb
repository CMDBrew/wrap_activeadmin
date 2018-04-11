require 'rails/generators/active_record'
require 'cb_stem/generators/helper'

module CbStem

  module Generators

    # Generates Uploaders
    class UploadersGenerator < Rails::Generators::Base

      include ::CbStem::Generators::Helper

      source_root File.expand_path('templates', __dir__)

      def setup_directory
        empty_directory 'app/uploaders/cb_stem'
      end

      def generate_uploaders
        %w[
          application cb_stem/avatar
        ].each do |file|
          template(
            "#{file}_uploader.rb.erb",
            "app/uploaders/#{file}_uploader.rb"
          )
        end
      end

    end

  end

end
