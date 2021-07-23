# frozen_string_literal: true

require_relative 'routes_map'

module ResourceUrlHelper
  class Resolver
    def initialize(item, options)
      @item = item
      @options = options
    end

    def call
      method = resolve_route_method
      name = method.sub(/_(path|url)$/, '').to_sym
      url_helpers.send(method, resolve_resource_options(name))
    end

    private

    def url_helpers
      Rails.application.routes.url_helpers
    end

    def resolve_route_method
      type = resolve_type
      action = resolve_action
      ActionDispatch::Routing::PolymorphicRoutes::HelperMethodBuilder.get(action, type).handle_model(@item)[0]
    end

    def resolve_type
      if @options[:only_path]
        :path
      else
        :url
      end
    end

    def resolve_action
      if @options[:action] && @options[:action].to_s != 'show'
        @options[:action].to_s
      else
        nil
      end
    end

    def resolve_resource_options(name)
      if (route = RoutesMap[name])
        recognize_parts(route)
      else
        {}
      end
    end

    def recognize_parts(route)
      hash = @options.dup
      route.required_parts.each do |part|
        if !hash.key?(part) && @item.respond_to?(part)
          object = @item.public_send(part)
          if object
            hash[part] = object
          elsif @item.class.respond_to?(:reflect_on_association) && @item.class.reflect_on_association(part).present?
            hash[part] = '0'
          end
        end
      end
      hash
    end
  end
end
