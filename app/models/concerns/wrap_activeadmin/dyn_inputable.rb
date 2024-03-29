module WrapActiveadmin

  module DynInputable

    extend ActiveSupport::Concern

    I18N_WHITELIST = %w[value_string value_text value_number].freeze

    included do
      has_many :dyn_input_configs, as: :dyn_inputable,
                                   class_name: 'WrapActiveadmin::DynInputConfig',
                                   inverse_of: :dyn_inputable,
                                   dependent: :destroy
      has_many :dyn_input_groups, through: :dyn_input_configs
      has_many :dyn_inputs,       through: :dyn_input_groups

      accepts_nested_attributes_for :dyn_input_configs,
                                    reject_if: :all_blank,
                                    allow_destroy: true
    end

    # rubocop:disable Metrics/BlockLength
    class_methods do
      def define_dyn_configs(*args)
        args.collect { |k| define_configs_association(k) }
      end

      def human_attribute_name(attribute, default: nil)
        hit = (I18N_WHITELIST & attribute.to_s.split('.'))
        if hit.present?
          WrapActiveadmin::DynInput.human_attribute_name(hit.first)
        else
          super
        end
      end

      def dyn_inputable_params(reference_key: 'dyn_input_configs')
        attrs = {}
        attrs["#{reference_key}_attributes"] = WrapActiveadmin::DynInputConfig.permitted_params
        [attrs]
      end

      def refresh_dyn_inputable_configs
        find_each.map do |x|
          x.update_dyn_input_configs
          x.update_dyn_inputs
        end
      end

      def define_configs_association(reference_key)
        has_many reference_key,
                 -> { where(reference_key: reference_key.to_s) },
                 as: :dyn_inputable,
                 class_name: 'WrapActiveadmin::DynInputConfig',
                 inverse_of: :dyn_inputable

        accepts_nested_attributes_for reference_key,
                                      reject_if: :all_blank,
                                      allow_destroy: true
      end
    end
    # rubocop:enable Metrics/BlockLength

    def dyn_inputable_configs(reference_key: 'dyn_input_configs')
      path = Rails.root.join('db', 'dyn_inputable', "#{self.class.to_s.underscore}.yml").to_s
      return unless File.exist?(path)
      key = inputable_config_mapping_key && try(inputable_config_mapping_key)
      if reference_key == 'dyn_input_configs'
        load_dyn_input_config(key: key, path: path)
      else
        load_dyn_input_config(key: key, path: path, reference: reference_key)
      end
    end

    def dyn_collection(reference_key:)
      dyn_input_configs.
        find_by(reference_key: reference_key)&.dyn_input_groups
    end

    def dyn_resource(reference_key:)
      dyn_input_configs.
        find_by(reference_key: reference_key)&.dyn_input_groups&.first
    end

    def update_dyn_inputs
      dyn_input_configs.each do |x|
        inputs = x.config
        keys   = inputs.map { |d| d['reference_key'] }
        x.dyn_inputs.not_with_keys(keys)&.destroy_all
        x.dyn_inputs.find_each(&:save)
      end
    end

    def update_dyn_input_configs
      return unless try(:dyn_inputable_configs)
      keys = dyn_inputable_configs.map { |x| x[:reference_key] }
      dyn_input_configs.not_with_keys(keys)&.destroy_all
      dyn_inputable_configs.each do |x|
        dyn_input_configs.find_by(reference_key: x[:reference_key])&.update(x)
      end
    end

    private

    def inputable_config_mapping_key
      nil
    end

    def load_dyn_input_config(key:, path:, reference: nil)
      file = YAML.load_file(path)
      file.map(&:deep_symbolize_keys!)
      configs = key.present? ? file.find { |x| x[:id] == key }&.fetch(:configs, {}) : file
      reference.present? ? configs.select { |x| x[:reference_key] == reference } : configs
    end

  end

end
