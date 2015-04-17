namespace :db do
	desc "Fill database with admin user data"
	task populate: :environment do
		user = Rhinoart::User.create!(
			name: "Admin",
			email: "admin@test.com",
			name: "Admin User",
			admin_role: "Super User",
			approved: 1,
			password: "admin",
			password_confirmation: "admin",
		)

		# add admin roles
		Rhinoart::User::ADMIN_PANEL_ROLES.each do |role|
			Role.create!(name: role) if !Role.find_by_name(role)
		end

		# add frontend roles
		Rhinoart::User::FRONTEND_ROLES.each do |role|
			Role.create!(name: role) if !Role.find_by_name(role)
		end

		# append admin roles
		user.add_role = Rhinoart::User::ADMIN_PANEL_ROLE_SUPER_USER
		user.add_role = Rhinoart::User::ADMIN_PANEL_ROLE_USERS_MANAGER
	end
end