# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'GoogleVoiceParser/version'

Gem::Specification.new do |spec|
  spec.name          = "GoogleVoiceParser"
  spec.version       = GoogleVoiceParser::VERSION
  spec.authors       = ["Jake Schievink"]
  spec.email         = ["jakeschievink@gmail.com"]
  spec.summary       = "Extracts google voice data and turns it into a json file"
  spec.description   = "longer description"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "thor", "~> 0.19"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
