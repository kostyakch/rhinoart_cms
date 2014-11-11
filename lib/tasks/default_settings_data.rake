namespace :db do
  desc "Fill database with settings data"
  task populate: :environment do
  	Rhinoart::Setting.create!(name: 'site_name', value: 'RhinoArt (change_me)', descr: 'Site name. Shown on title')
  	Rhinoart::Setting.create!(name: 'disabled_pages', value: '01,02', descr: 'Pages iDs for disable pages')
  	Rhinoart::Setting.create!(name: 'seo_code', value: '', descr: 'Code for Google Analytics, verification code, etc')
  end

end
