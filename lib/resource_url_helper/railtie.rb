# frozen_string_literal: true

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
