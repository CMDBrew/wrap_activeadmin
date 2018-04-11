module CbStem

  class ContentConfig < ApplicationRecord

    include CbStem::NameGenerator
    include CbStem::IdentifierGenerator
    assign_name       :name,
                      scope: :cb_stem_content_model_config_id
    assign_identifier :name, :reference_key,
                      scope: :cb_stem_content_model_config_id

    belongs_to :content_model_config,
               class_name: 'CbStem::ContentModelConfig',
               foreign_key: 'cb_stem_content_model_config_id',
               required: true,
               inverse_of: 'content_configs'

    has_many :input_group_configs,
             dependent: :destroy,
             class_name: 'CbStem::InputGroupConfig',
             foreign_key: 'cb_stem_content_config_id',
             inverse_of: 'content_config'

  end

end
