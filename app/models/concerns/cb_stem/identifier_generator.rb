module CbStem

  module IdentifierGenerator

    extend ActiveSupport::Concern

    class_methods do
      def assign_identifier(reference, key, scope: nil)
        before_validation -> { generate_identifier(reference, key, scope) }

        validates reference, presence: true
        validates key, uniqueness: { scope: scope } if scope.present?
      end
    end

    private

    # rubocop:disable Metrics/MethodLength
    def generate_identifier(reference, key, scope)
      return if try(reference).blank?
      i = 0
      identifier = ''
      loop do
        identifier = try(key).presence || try(reference).presence
        identifier = identifier.parameterize(separator: '_')
        identifier = "#{identifier}_#{i}" if i.positive?
        break unless identifier_invalid?(key, identifier, scope)
        i += 1
      end
      send("#{key}=", identifier)
    end
    # rubocop:enable Metrics/MethodLength

    def identifier_invalid?(key, name, scope)
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
