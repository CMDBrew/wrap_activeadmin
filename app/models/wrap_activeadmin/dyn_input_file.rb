module WrapActiveadmin

  class DynInputFile < DynInput

    mount_uploader :value_string, WrapActiveadmin::MediaUploader

    validates :value_string,
              presence: true,
              if: proc { field_config['required'] }

    validate :in_whitelist

    alias_attribute :value,     :value_string
    alias_attribute :value_url, :value_string_url

    def extension_whitelist
      false
    end

    private

    def in_whitelist
      file      = value_string.file
      valid_ext = field_config['whitelist']
      return if file.blank? || valid_ext.include?(file.extension&.downcase)
      errors.add(:value_string,
                 I18n.t(:extension_whitelist_error,
                        scope: %i[errors messages],
                        extension: file.extension,
                        allowed_types: valid_ext.join(', ')))
    end

  end

end
