# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xorer/version'

Gem::Specification.new do |spec|
  spec.name          = "xorer"
  spec.version       = Xorer::VERSION
  spec.authors       = ["Chris Hendrix"]
  spec.email         = ["cah276@cornell.edu"]
  spec.summary       = %q{Xors things}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'rspec'
end
