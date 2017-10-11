# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "meta_commit_ruby_support/version"

Gem::Specification.new do |spec|
  spec.name          = "meta_commit_ruby_support"
  spec.version       = MetaCommit::Extension::RubySupport::VERSION
  spec.authors       = ["Stanislav Dobrovolskiy"]
  spec.email         = ["uusername@protonmail.ch"]

  spec.summary       = %q{meta_commit extension adds ruby language support}
  spec.homepage      = "https://github.com/meta_commit/ruby_support"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/})}
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "meta_commit_contracts", "~> 0.1.2"
  spec.add_runtime_dependency "parser", "2.3.0"

  spec.add_development_dependency "bundler",      "~> 1.15"
  spec.add_development_dependency "rake",         "~> 10.0"
  spec.add_development_dependency "rspec",        "~> 3.6"
  spec.add_development_dependency "rspec-mocks",  "~> 3.6"
  spec.add_development_dependency "coveralls",    "~> 0.8"
end
