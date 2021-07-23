# frozen_string_literal: true

require_relative 'resolver'

module ResourceUrlHelper
  module Controller
    def resource_url_for(item, options = {})
      Resolver.new(item, options.reverse_merge(default_url_options.merge(only_path: true))).call
    end
  end
end
