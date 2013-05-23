$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tgp/gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tgp_gem"
  s.version     = Tgp::Gem::VERSION
  s.authors     = ["The Giant Pixel"]
  s.email       = ["gems@thegiantpixel.com"]
  s.homepage    = "http://www.thegiantpixel.com"
  s.summary     = "TGP Gem Base for creating gems"
  s.description = "The Giant Pixel Base for creating gems"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "geminabox"

  s.add_dependency "rails", "~> 3.2.8"
end
