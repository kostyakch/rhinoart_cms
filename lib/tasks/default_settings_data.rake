namespace :db do
  desc "Fill database with settings data"
  task populate: :environment do
  	Rhinoart::Setting.create!(name: 'site_name', value: 'RhinoArt (change_me)', descr: 'Site name. Shown on title')
  	Rhinoart::Setting.create!(name: 'disabled_pages', descr: 'Pages iDs for disable pages')

  	Rhinoart::Setting.create!(name: 'head_tags', descr: 'Common site tags, verification code, etc')
  	Rhinoart::Setting.create!(name: 'analytics_code', descr: 'Code for Google Analytics, etc')  	
  end

end
