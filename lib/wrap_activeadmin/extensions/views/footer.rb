module ActiveAdmin

  module Views

    # Overwriting Footer - activeadmin/lib/active_admin/views/footer.rb
    class Footer < Component

      WRAPPER_CLASS = 'text-center text-muted m-4'.freeze

      def build(namespace)
        super(id: 'footer', class: WRAPPER_CLASS)
        @namespace = namespace
        small(footer? ? footer_text : powered_by_message)
      end

      private

      def powered_by_message
        I18n.t('wrap_activeadmin.powered_by',
               year: Time.zone.now.year,
               owner: t('wrap_activeadmin.owner'),
               version: WrapActiveadmin::VERSION)
      end

    end

  end

end
