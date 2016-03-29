$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cwk/gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cwk_gem"
  s.version     = Cwk::Gem::VERSION
  s.authors     = ["John Cwikla"]
  s.email       = ["gems@cwikla.com"]
  s.homepage    = "http://www.cwikla.com"
  s.summary     = "Gem Base for creating gems"
  s.description = "Base for creating gems"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "geminabox"

  s.add_dependency "rails", "~> 4.2.6"
end
