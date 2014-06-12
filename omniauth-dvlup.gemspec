$:.push File.expand_path("../lib", __FILE__)
require 'omniauth/dvlup/version'

Gem::Specification.new do |gem|
  gem.add_dependency "omniauth", "~> 1.2.1"
  gem.add_runtime_dependency "omniauth-oauth2", "~> 1.1.2"

  gem.name        = "omniauth-dvlup"
  gem.version     = OmniAuth::DVLUP::VERSION
  gem.authors     = ["Jon Hyman"]
  gem.email       = ["jon@appboy.com"]
  gem.homepage    = "https://github.com/jonhyman/omniauth-dvlup"
  gem.summary     = "Nokia DVLUP Strategy for OmniAuth"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", ">= 2.14.0"
  gem.add_development_dependency "rake"
end
