module CbStem

  class ContentModelConfig < ApplicationRecord

    include CbStem::IdentifierGenerator
    assign_identifier :name, :reference_key

    acts_as_list

    has_many :content_configs,
             dependent: :destroy,
             class_name: 'CbStem::ContentConfig',
             foreign_key: 'cb_stem_content_model_config_id',
             inverse_of: 'content_model_config'

    before_save :build_content_config, if: proc { content_configs.blank? }

    validates :name, uniqueness: true

    private

    def build_content_config
      content_configs.build
    end

  end

end
