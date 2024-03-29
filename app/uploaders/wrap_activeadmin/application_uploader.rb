module WrapActiveadmin

  # Application Uploader For Asset Uploads
  class ApplicationUploader < CarrierWave::Uploader::Base

    IMAGE_TYPES = %w[svg jpg jpeg gif png].freeze
    FILE_TYPES  = %w[pdf doc docx json csv xlsx].freeze
    VIDEO_TYPES = %w[mov avi mkv mpeg mpeg2 mp4 3gp].freeze
    AUDIO_TYPES = %w[mp3 wma ra ram rm mid ogg].freeze

    include CarrierWave::RMagick

    process :save_meta_to_model

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def extension_whitelist
      whitelist_method =
        [mounted_as, :extension_whitelist].join('_')
      model.try(whitelist_method) ||
        model.try(:extension_whitelist) ||
        default_whitelist
    end

    def default_whitelist
      IMAGE_TYPES + FILE_TYPES + VIDEO_TYPES + AUDIO_TYPES
    end

    def audio?(new_file = self)
      new_file.content_type &&
        new_file.content_type&.start_with?('audio')
    end

    def image?(new_file = self)
      new_file.content_type &&
        new_file.content_type&.start_with?('image')
    end

    def file?(new_file = self)
      new_file.content_type &&
        new_file.content_type&.start_with?('application')
    end

    def video?(new_file = self)
      new_file.content_type &&
        new_file.content_type&.start_with?('video')
    end

    def pdf?(new_file = self)
      new_file.content_type &&
        new_file.content_type&.eql?('application/pdf')
    end

    def size_range
      WrapActiveadmin.file_size
    end

    protected

    def process_upload?(_file)
      !model.respond_to?(:background_upload) ||
        model.background_upload == true
    end

    def save_meta_to_model
      file_type_attr = [mounted_as, 'file_type'].join('_')
      file_size_attr = [mounted_as, 'file_size'].join('_')
      model.try("#{file_type_attr}=", file.content_type) if file.content_type
      model.try("#{file_size_attr}=", file.size)
    end

  end

end
