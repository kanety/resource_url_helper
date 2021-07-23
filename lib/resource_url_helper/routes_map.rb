# frozen_string_literal: true

module ResourceUrlHelper
  class RoutesMap
    class_attribute :map

    class << self
      def [](name)
        self.map ||= load
        map[name]
      end

      private

      def load
        Rails.application.routes.routes.index_by { |route| route.name.to_s.to_sym }
      end
    end
  end
end
