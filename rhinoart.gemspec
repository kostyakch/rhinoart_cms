$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rhinoart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rhinoart"
  s.version     = Rhinoart::VERSION
  s.authors     = ["Konstantin Chernyaev"]
  s.email       = ["kch@list.ru"]
  s.homepage    = "http://rhinoart.ru"
  s.summary     = "Admin CMS"
  s.description = "Admin engine for make CMS"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency "mysql2", "0.3.15"
  s.add_dependency "bcrypt-ruby"
  s.add_dependency "will_paginate"
  s.add_dependency "acts_as_list"
  s.add_dependency "jquery-rails"
  s.add_dependency 'sass-rails', '~> 4.0.0'
  s.add_dependency 'bootstrap-will_paginate'
  s.add_dependency 'bootstrap-datepicker-rails'
  s.add_dependency 'russian', '~> 0.6.0'
  
  s.add_dependency "mini_magick"
  s.add_dependency "carrierwave"

  #s.add_dependency "rails-observers"
  #s.add_development_dependency "sqlite3"
end
