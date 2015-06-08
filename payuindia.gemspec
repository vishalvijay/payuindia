# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payuindia/version'

Gem::Specification.new do |spec|
  spec.name          = "payuindia"
  spec.version       = PayuIndia::VERSION
  spec.authors       = ["Sandeep Kumar"]
  spec.email         = ["sandeep.kumar@payu.in"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://rubygems.org"
  end

  spec.summary       = %q{Gem for Ruby on Rails Apps.}
  spec.description   = %q{Gem for Ruby on Rails Apps which integrate with PayU India Payment Gateway}
  spec.homepage      = "https://github.com/payu-india/payuindia"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('httparty', '~> 0.13.5')

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
