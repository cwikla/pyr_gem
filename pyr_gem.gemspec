$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pyr/gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pyr_gem"
  s.version     = Pyr::Gem::VERSION
  s.authors     = ["John Cwikla"]
  s.email       = ["pyr@cwikla.com"]
  s.homepage    = "http://www.cwikla.com"
  s.summary     = "Gem Base for creating gems"
  s.description = "Base for creating gems"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "geminabox" , ">= 0.13.5"

  #s.add_dependency "rails", "5.0.0beta3"
  s.add_dependency "rails", "~> 6"
end
