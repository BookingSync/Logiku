# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logiku/version'

Gem::Specification.new do |spec|
  spec.name          = "logiku"
  spec.version       = Logiku::VERSION
  spec.authors       = ["thilonel"]
  spec.email         = ["naitodai@gmail.com"]

  spec.summary       = "A log formatter gem."
  spec.description   = "At BookingSync, we use this to achieve a lean and consistent log output."
  spec.homepage      = "https://github.com/BookingSync/Logiku"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
end
