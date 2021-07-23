# frozen_string_literal: true

require_relative 'resolver'

module ResourceUrlHelper
  module RoutesHelper
    def resource_url_for(item, options = {})
      Resolver.new(item, options.reverse_merge(Rails.application.routes.default_url_options)).call
    end
  end
end
