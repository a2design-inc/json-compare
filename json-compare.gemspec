# -*- encoding: utf-8 -*-
require File.expand_path('../lib/json-compare/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stanislav Chistenko"]
  gem.email         = ["skvest1@gmail.com"]
  gem.description   = %q{Returns the difference between two JSON files}
  gem.summary       = %q{JSON Comparer}
  gem.homepage      = "https://github.com/a2design-company/json-compare"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "json-compare"
  gem.require_paths = ["lib"]
  gem.version       = JsonCompare::VERSION

  # tests
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', ">= 2.0.0"
  gem.add_development_dependency 'yajl-ruby'
end
