$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'rhinoart/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rhinoart'
  s.version     = Rhinoart::VERSION
  s.authors     = ['Konstantin Chernyaev']
  s.email       = ['kch@list.ru']
  s.homepage    = 'http://rhinocms.ru/'
  s.summary     = 'Rhinoart CMS'
  s.description = 'Rhinoart CMS. This is a backend engine for making site'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'acts_as_list'
  s.add_dependency 'rails', '5.2.1'
  s.add_dependency 'will_paginate'

  s.add_dependency 'haml-rails'

  s.add_dependency 'bootstrap-datepicker-rails'
  s.add_dependency 'bootstrap-will_paginate'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'russian', '~> 0.6.0'
  s.add_dependency 'sass-rails'

  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'

  s.add_dependency 'cancan'
  s.add_dependency 'devise'
  s.add_dependency 'rolify'

  # s.add_dependency 'globalize', '~> 5.1.0'
  # s.add_dependency 'globalize-accessors'
  # s.add_dependency 'globalize-versioning'
  s.add_dependency 'omniauth-google-oauth2'
  s.add_dependency 'omniauth-oauth2' 
  s.add_dependency 'paper_trail'
end
