# frozen_string_literal: true

module ResourceUrlHelper
  module Helper
    delegate :resource_url_for, to: :controller
  end
end
