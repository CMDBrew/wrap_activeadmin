$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cb_stem/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cb_stem'
  s.version     = CbStem::VERSION
  s.authors     = ['Clever Banana Studios Inc.']
  s.email       = ['dev@cleverbanana.com']
  s.homepage    = 'http://www.cleverbanana.com'
  s.summary     = 'Cb::Stem is a generic backend panel based on ActiveAdmin'
  s.description = 'Cb::Stem is used as the base backend panel for all our clients.'
  s.license     = 'Copyright Clever Banana Studios Inc.'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.0.2'
  s.add_dependency 'slim-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'activeadmin', '~> 1.2.1'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails', '~> 5.0.5'
  s.add_dependency 'select2-rails'
  s.add_dependency 'friendly_id', '~> 5.1.0'
  s.add_dependency 'carrierwave', '~> 1.0'
  s.add_dependency 'acts-as-taggable-on', '~> 4.0'
  s.add_dependency 'acts_as_list', '~> 0.9.10'
  s.add_dependency 'devise'
  s.add_dependency 'bootstrap', '~> 4.0.0'
  s.add_dependency 'font-awesome-sass', '~> 4.5.0'
  s.add_dependency 'bootstrap-datepicker-rails'

  s.add_development_dependency 'devise'
  s.add_development_dependency 'pg', '~> 0.15'
  s.add_development_dependency 'thin'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'interactive_editor'
  s.add_development_dependency 'letter_opener'
end
