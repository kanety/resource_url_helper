# frozen_string_literal: true

require 'active_support/all'

require 'resource_url_helper/config'
require 'resource_url_helper/controller'
require 'resource_url_helper/helper'
require 'resource_url_helper/routes_helper'
require 'resource_url_helper/railtie' if defined?(Rails)

module ResourceUrlHelper
  class << self
    def configure
      yield Config
    end

    def config
      Config
    end
  end
end
