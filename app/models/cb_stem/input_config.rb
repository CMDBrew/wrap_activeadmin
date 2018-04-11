module CbStem

  class InputConfig < ApplicationRecord

    include CbStem::NameGenerator
    include CbStem::IdentifierGenerator
    assign_name       :name,
                      scope: :cb_stem_input_group_config_id
    assign_identifier :name, :reference_key,
                      scope: :cb_stem_input_group_config_id

    enum input_type: {
      input_string: 0, input_text: 1, input_select: 2,
      input_boolean: 3, input_datetime: 4, input_color: 5
    }

    belongs_to :input_group_config,
               required: true,
               class_name: 'CbStem::InputGroupConfig',
               foreign_key: 'cb_stem_input_group_config_id',
               inverse_of: 'input_configs'

    def self.icon_mapping
      {
        input_string:   { icon: 'edit-2',           color: 'bg-yellow' },
        input_text:     { icon: 'capitalize',       color: 'bg-yellow' },
        input_select:   { icon: 'check-square-11',  color: 'bg-green' },
        input_datetime: { icon: 'calendar-grid-61', color: 'bg-red' },
        input_boolean:  { icon: 'ui-03',            color: 'bg-green' },
        input_color:    { icon: 'palette',          color: 'bg-purple' }
      }
    end

  end

end
