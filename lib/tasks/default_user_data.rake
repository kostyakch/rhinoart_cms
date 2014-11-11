namespace :db do
  desc "Fill database with admin user data"
  task populate: :environment do
    Rhinoart::User.create!(name: "Admin",
                 email: "admin@test.com",
                 name: "Admin User",
                 admin_role: "Super User",
                 approved: 1,
                 password: "admin",
                 password_confirmation: "admin",
                 )
  end
end