module CbStem

  # Decorates ContentModelConfig Object
  class Admin::ContentModelConfigDecorator < ApplicationDecorator

    decorates 'cb_stem/content_model_config'

    def identifier
      h.link_to object.name, [:admin, :cb_stem, object]
    end

  end

end
