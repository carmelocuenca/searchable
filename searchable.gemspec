$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "searchable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "searchable"
  s.version     = Searchable::VERSION
  s.authors     = ["Carmelo Cuenca"]
  s.email       = ["carmelocuenca@hotmail.com"]
  s.homepage    = "https://github.com/carmelocuenca/searchable"
  s.summary     = "Un plugin para Rails 4 que incluye utilidades de búsqueda que extiende la clase ActiveRecord::Base"
  s.description = "Un plugin para Rails 4 que incluye utilidades de búsqueda que extiende la clase ActiveRecord::Base"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "faker"
end
