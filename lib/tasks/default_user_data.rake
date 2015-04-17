namespace :db do
	desc "Fill database with admin user data"
	task populate: :environment do
		user = Rhinoart::User.create!(
			name: "Admin",
			email: "admin@test.com",
			name: "Admin User",
			approved: 1,
			password: "admin",
			password_confirmation: "admin",
		)
    user.add_role("Super User")
	end
end