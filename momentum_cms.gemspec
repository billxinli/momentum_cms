$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "momentum_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "momentum_cms"
  s.version     = MomentumCms::VERSION
  s.authors     = ['Emerson', 'Bill']
  s.email       = ['emerson@twg.ca', 'bill@twg.ca']
  s.homepage    = 'https://github.com/MomentumCMS/'
  s.summary     = "MomentumCMS: summary"
  s.description = "MomentumCMS: description"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
