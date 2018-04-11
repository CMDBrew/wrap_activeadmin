ActiveAdmin.register CbStem::ContentModelConfig do
  decorate_with ::CbStem::Admin::ContentModelConfigDecorator

  menu label:
         proc {
           menu_label(CbStem::ContentModelConfig.model_name.human(count: 2), icon: 'database')
         },
       priority: 99

  permit_params :name, :reference_key

  # CONTROLLER
  controller do
    def create
      create! do |success, _failure|
        success.html { redirect_to resource_path }
      end
    end
  end

  # INDEX
  index do
    selectable_column
    column :name, :identifier
    column :reference_key
    column :updated_at
    actions(defaults: false) do |x|
      item t('active_admin.edit'), [:edit, :admin, :cb_stem, x]
      item t('cb_stem.resource.content_config.actions.view'), [:admin, :cb_stem, x]
      item t('active_admin.destroy'),
           [:admin, :cb_stem, x],
           method: :delete,
           data: { confirm: I18n.t('active_admin.delete_confirmation') }
    end
  end

  # FORM
  form do |f|
    f.inputs do
      f.input :name
      f.input :reference_key
    end
    hr
    f.actions
  end

  # SHOW
  sidebar '', only: :show, class: 'transparent' do
    CbStem::InputConfig.input_types.keys.each do |key|
      config = CbStem::InputConfig.icon_mapping.dig(key.to_sym)
      next if config.blank?
      div class: 'card table-item-identifier p-1 mb-2' do
        div class: "thumbnail-icon #{config[:color]} mr-2" do
          content_tag(:i, '', class: "nc-icon text-white nc-#{config[:icon]}")
        end
        span key
      end
    end
  end

  show do
    div id: 'content_configs' do
      render resource.content_configs
    end
    text_node(
      link_to(
        [:admin, :cb_stem, resource, :cb_stem, :content_configs],
        class: 'btn btn-light btn-lg btn-block', method: :post, remote: true
      ) do
        content_tag(:i, '', class: 'nc-icon nc-simple-add')
      end
    )
  end
end
