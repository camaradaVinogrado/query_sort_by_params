$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "query_sort_by_params/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "query_sort_by_params"
  s.version     = QuerySortByParams::VERSION
  s.authors     = ["Austin Matzko"]
  s.email       = ["austin@pressedcode.com"]
  s.homepage    = "https://github.com/matzko/query_sort_by_params"
  s.summary     = "Allow the sorting of ActiveRecord queries by model field names and arbitrary associations"
  s.description = "Allow the sorting of ActiveRecord queries by model field names and arbitrary associations"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.2.3"

  s.add_development_dependency "sqlite3"
	s.add_development_dependency "rspec-rails"
	s.add_development_dependency "rspec-activemodel-mocks"
	s.add_development_dependency "factory_girl_rails", "~> 4.0"
	s.add_development_dependency "fuubar"
	s.add_development_dependency "timecop"
	s.add_development_dependency "database_cleaner"
	s.add_development_dependency "pry-rails"
	s.add_development_dependency "pry-byebug"
end
