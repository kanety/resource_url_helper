# frozen_string_literal: true

if Rails.gem_version < Gem::Version.new('6.1.0')
  class ActionDispatch::Routing::RouteSet
    alias_method :original_url_helpers, :url_helpers
    def url_helpers(supports_path = true)
      if supports_path
        @url_helpers_with_paths ||= original_url_helpers(true)
      else
        @url_helpers_without_paths ||= original_url_helpers(false)
      end
    end
  end
end

module ResourceUrlHelper
  class Railtie < Rails::Railtie
    config.after_initialize do
      Rails.application.routes.url_helpers.extend ResourceUrlHelper::RoutesHelper
    end

    ActiveSupport.on_load :action_controller do
      ActionController::Base.send :include, ResourceUrlHelper::Controller
    end

    ActiveSupport.on_load :action_view do
      ActionView::Base.send :include, ResourceUrlHelper::Helper
    end
  end
end
