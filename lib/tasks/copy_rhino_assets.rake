namespace :rhinoart do
  desc 'Copy Rhinoart static assets'
  task :copy_rhino_assets => :environment do
    FileUtils.remove_dir(Rails.root.join('public/assets/img'), true)
    FileUtils.remove_dir(Rails.root.join('public/assets/font'), true)
    FileUtils.cp_r(
      Rhinoart::Engine.root.join('app/assets/stylesheets/font'),
      Rails.root.join('public/assets/font')
    )
    FileUtils.cp_r(
      Rhinoart::Engine.root.join('app/assets/stylesheets/img'),
      Rails.root.join('public/assets/img')
    )
  end
end