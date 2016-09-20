# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'followanalytics/version'

Gem::Specification.new do |spec|
  spec.name          = "followanalytics"
  spec.email         = "technique@followanalytics.com"
  spec.version       = Followanalytics::VERSION
  spec.required_ruby_version = '>= 2.0.0'
  spec.authors       = ["José Carlos Joaquim"]
  spec.summary       = %q{Ruby client for the FollowAnalytics API.}
  spec.description   = %q{Ruby client for the FollowAnalytics API.}
  spec.homepage      = "https://github.com/followanalytics/fa-api-gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'rest-client', '~> 2.0'
  spec.add_dependency 'oj', '~> 2.17'
end
