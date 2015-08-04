$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "query_sort_by_params/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "query_sort_by_params"
  s.version     = QuerySortByParams::VERSION
  s.authors     = ["Austin Matzko"]
  s.email       = ["austin@pressedcode.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of QuerySortByParams."
  s.description = "TODO: Description of QuerySortByParams."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
	s.add_development_dependency "rspec-rails"
	s.add_development_dependency "rspec-activemodel-mocks"
	s.add_development_dependency "factory_girl_rails", "~> 4.0"
	s.add_development_dependency "fuubar"
	s.add_development_dependency "timecop"
end
