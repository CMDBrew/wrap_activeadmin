module ActiveAdmin

  module Views

    # Custom Component - Chart
    class Chart < ActiveAdmin::Component

      builder_method :chart

      def default_class_name
        'cb-stem-chart'
      end

      def build(type:, label:, data:, options: {})
        div do
          content_tag(
            :canvas, '',
            data: {
              'js': "#{type}-chart",
              'chart-label': label,
              'chart-data':  data
            }.reverse_merge!(options)
          )
        end
      end

    end

  end

end
