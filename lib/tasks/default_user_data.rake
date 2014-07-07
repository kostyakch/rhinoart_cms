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

    # 99.times do |n|
    #   name  = Faker::Name.name
    #   email = Faker::Internet.email
    #   password  = "password"
    #   User.create!(name: name,
    #                email: email,
    #                password: password,
    #                password_confirmation: password)
    # end
  end
end