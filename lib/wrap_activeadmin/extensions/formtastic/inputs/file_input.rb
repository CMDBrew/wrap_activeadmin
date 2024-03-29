module Formtastic

  module Inputs

    # Overwriting Formastic Default FileInput - formtastic/lib/formtastic/inputs/file_input.rb
    class FileInput

      include Base

      def to_html
        input_wrapping do
          label_html << file_input
        end
      end

      def file_input
        template.content_tag(:div, class: file_input_class) do
          attachment_preview + file_placeholder + file_button
        end
      end

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      def attachment_preview
        template.content_tag :div, class: 'file-preview' do
          if object.try(method).present? && image?(object.try(method))
            version =
              object.try(method)&.versions&.map(&:first) & WrapActiveadmin.file_preview_versions
            if version.empty?
              template.image_tag(object.try(method)&.url)
            else
              template.image_tag(object.try(method)&.url(version.first))
            end
          end
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

      def file_input_class
        klass = %w[form-control-file form-control]
        klass << 'active' if attachment.present?
        klass.join(' ')
      end

      private

      def image?(file)
        return false if file.blank?
        file_type = object.try("#{file.mounted_as}_file_type").presence || file.content_type
        file_type && file_type&.start_with?('image')
      end

      def attachment
        object.try("#{method}_identifier")
      end

      def file_placeholder
        template.content_tag(:div, attachment, class: 'file-text mx-2') <<
          template.content_tag(
            :div, ::I18n.t('wrap_activeadmin.form.placeholders.choose_file'),
            class: 'file-placeholder text-muted mx-2'
          )
      end

      def file_button
        template.content_tag(
          :label, label_text, class: 'file-input btn btn-sm btn-light mb-0'
        ) do
          template.content_tag(:span, ::I18n.t('wrap_activeadmin.form.choose_file')) <<
            builder.file_field(method, input_html_options)
        end
      end

    end

  end

end
