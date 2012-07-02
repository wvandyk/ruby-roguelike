# -*- encoding: utf-8 -*-
require File.expand_path('../lib/roguelike/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Wynand van Dyk"]
  gem.email         = ["wvandyk@gmail.com"]
  gem.description   = %q{Rudimentary ruby roguelike with ncurses-ruby, built in a test driven fashion to make the ruby reek tool complain as little as possible for maximum code cleanliness}
  gem.summary       = %q{Rudimentary ruby roguelike}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "roguelike"
  gem.require_paths = ["lib"]
  gem.version       = Roguelike::VERSION
  gem.add_dependency 'ncurses-ruby', '~> 1.2.1'
  gem.add_development_dependency 'rspec', '~> 2.10.0'
  gem.add_development_dependency 'reek', '~> 1.2.12'
end
