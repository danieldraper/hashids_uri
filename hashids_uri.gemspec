# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hashids_uri/version'

Gem::Specification.new do |spec|
  spec.name          = "hashids_uri"
  spec.version       = HashidsUri::VERSION
  spec.authors       = ["Daniel Draper"]
  spec.email         = ["hello@danieldraper.com.au"]

  spec.summary       = %q{Use HashidsUri to hide your sequential ids from the URL.}
  spec.description   = %q{HashidsUri turns your sequentially generated id in the URL into a Hashid see **hashids.org**.}
  spec.homepage      = "https://github.com/danieldraper/hashids_uri"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_dependency "hashids",      "~> 1.0.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency 'sqlite3'
end
