# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resource_url_helper/version'

Gem::Specification.new do |spec|
  spec.name          = "resource_url_helper"
  spec.version       = ResourceUrlHelper::VERSION
  spec.authors       = ["Yoshikazu Kaneta"]
  spec.email         = ["kaneta@sitebridge.co.jp"]
  spec.summary       = %q{Complement required url parameters from resource}
  spec.description   = %q{Complement required url parameters from resource}
  spec.homepage      = "https://github.com/kanety/resource_url_helper"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0"

  spec.add_development_dependency "rails", ">= 6.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"
end
