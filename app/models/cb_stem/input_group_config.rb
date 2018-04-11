module CbStem

  class InputGroupConfig < ApplicationRecord

    include CbStem::NameGenerator
    include CbStem::IdentifierGenerator
    assign_name       :name,
                      scope: :cb_stem_content_config_id
    assign_identifier :name, :reference_key,
                      scope: :cb_stem_content_config_id

    belongs_to :content_config,
               required: true,
               class_name: 'CbStem::ContentConfig',
               foreign_key: 'cb_stem_content_config_id',
               inverse_of: 'input_group_configs'

    has_many :input_configs,
             dependent: :destroy,
             class_name: 'CbStem::InputConfig',
             foreign_key: 'cb_stem_input_group_config_id',
             inverse_of: 'input_group_config'

  end

end
