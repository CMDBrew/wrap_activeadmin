module CbStem

  module NameGenerator

    extend ActiveSupport::Concern

    class_methods do
      def assign_name(key, scope: nil, name: nil)
        before_validation -> { generate_name(key, scope, name: name) }

        validates key, uniqueness: { scope: scope } if scope.present?
      end
    end

    private

    def generate_name(key, scope, name: nil)
      return if try(key).present?
      i = 0
      identifier = ''
      loop do
        identifier = name.presence || self.class.model_name.human
        identifier = "#{identifier} #{i}" if i.positive?
        break unless name_invalid?(key, identifier, scope)
        i += 1
      end
      send("#{key}=", identifier)
    end

    def name_invalid?(key, name, scope)
      query =
        if scope.present?
          ["#{scope} =? AND #{key} =?", try(scope), name]
        else
          ["#{key} =?", name]
        end
      self.class.exists?(query)
    end

  end

end
