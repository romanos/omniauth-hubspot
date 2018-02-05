# coding: utf-8
require File.expand_path('../lib/omniauth-hubspot/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "omniauth-hubspot-full"
  spec.version       = Omniauth::Hubspot::VERSION
  spec.authors       = ["romanos"]
  spec.email         = ["romanos@jargon.ai"]
  spec.description   = %q{OmniAuth strategy for Hubspot (borrowed heavily from @kmrshntr)}
  spec.summary       = %q{OmniAuth strategy for Hubspot (borrowed heavily from @kmrshntr)}
  spec.homepage      = "https://github.com/romanos/omniauth-hubspot.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth-oauth2', ">= 1.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
end
