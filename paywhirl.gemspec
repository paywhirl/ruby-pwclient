# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "paywhirl/version"

Gem::Specification.new do |spec|
  spec.name          = "paywhirl"
  spec.version       = Paywhirl::VERSION
  spec.authors       = ["PayWhirl"]
  spec.email         = ["megrims@gmail.com"]
  spec.required_ruby_version = ">= 1.9"
  spec.summary       = %q{API library for simplifying interaction with PayWhirl services.}
  spec.homepage      = "https://github.com/paywhirl/ruby-pwclient"
  spec.license       = "MIT"
  spec.description   = <<-EOF
    This library provides an interface to manage your PayWhirl account from
    within your own Ruby code.
  EOF
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_runtime_dependency "faraday", "~> 0.13.1"
end
