# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paywhirl/version'

Gem::Specification.new do |spec|
  spec.name          = 'paywhirl'
  spec.version       = Paywhirl::VERSION
  spec.authors       = ['PayWhirl']
  spec.email         = ['developer@paywhirl.com']
  spec.required_ruby_version = '>= 2.3'
  spec.summary       = 'API library for simplifying interaction with PayWhirl services.'
  spec.homepage      = 'https://github.com/paywhirl/ruby-pwclient'
  spec.license       = 'MIT'
  spec.description   = 'This library provides an interface to manage your ' \
                       'PayWhirl account from within your own Ruby code.'
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_runtime_dependency 'faraday', '~> 1.0.0'
end
