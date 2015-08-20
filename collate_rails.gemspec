$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "collate_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "collate_rails"
  s.version     = CollateRails::VERSION
  s.authors     = ["Jevon Wright"]
  s.email       = ["jevon@powershop.co.nz"]
  s.homepage    = "https://github.com/soundasleep/collate_rails"
  s.summary     = "Open source translations for Rails projects"
  s.description = "Open source translations for Rails projects"
  s.license     = "GPL-2.0"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.2"
end
