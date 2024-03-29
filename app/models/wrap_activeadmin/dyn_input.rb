module WrapActiveadmin

  class DynInput < ApplicationRecord

    TYPES = %w[
      WrapActiveadmin::DynInputText WrapActiveadmin::DynInputString
      WrapActiveadmin::DynInputNumber WrapActiveadmin::DynInputFile
      WrapActiveadmin::DynInputRelation WrapActiveadmin::DynInputSelect
      WrapActiveadmin::DynInputVideoEmbed
    ].freeze

    acts_as_list scope: :wrap_activeadmin_dyn_input_group_id

    belongs_to :dyn_input_group,
               class_name: 'WrapActiveadmin::DynInputGroup',
               foreign_key: 'wrap_activeadmin_dyn_input_group_id',
               inverse_of: :dyn_inputs,
               touch: true

    validates :reference_key, presence: true
    validates :type,          presence: true, inclusion: { in: TYPES }

    before_validation :mirror_configs

    delegate :config, to: :dyn_input_group, allow_nil: true

    default_scope { order(position: :asc) }
    scope :not_with_keys, ->(keys) { where.not(reference_key: keys) }

    def self.permitted_params
      %i[
        id label type position span reference_key required
        value_text value_string value_number input_config
        value_string_cache _destroy
      ] + [value_array: []]
    end

    def field_config
      return {} if config.blank?
      config.find { |x| x['reference_key'] == reference_key }
    end

    private

    def mirror_configs
      self.position = field_config['position']
      self.type     = "wrap_activeadmin/dyn_input_#{field_config['type']}".camelcase
    end

  end

end
