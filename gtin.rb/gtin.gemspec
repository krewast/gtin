# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gtin/version'

Gem::Specification.new do |spec|
  spec.name          = "gtin.rb"
  spec.version       = Gtin::VERSION
  spec.authors       = ["Powa Technologies Ltd", "Joseph Earl"]
  spec.email         = ["josephearl@powa.com"]
  spec.description   = %q{A Ruby gem for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.}
  spec.summary       = %q{gtin.rb}
  spec.homepage      = "https://github.com/powa/gtin"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
end
