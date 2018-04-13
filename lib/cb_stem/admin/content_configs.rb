if CbStem.enable_content_model
  ActiveAdmin.register CbStem::ContentConfig do
    belongs_to :content_model_config,
               class_name: 'CbStem::ContentModelConfig'

    menu false

    permit_params :name, :reference_key

    actions only: %i[]

    # ACTIONS
    collection_action :create, method: :post do
      content_model_config =
        CbStem::ContentModelConfig.find_by(id: params[:cb_stem_content_model_config_id])
      @content_config = content_model_config.content_configs.create
      render 'admin/cb_stem/content_configs/create'
    end
  end
end
