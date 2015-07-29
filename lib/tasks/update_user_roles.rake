namespace :rhinoart do
	desc "Update user roles to rolefy gem"
	task update_user_roles: :environment do
		Rhinoart::User.all.each do |user|
			roles = user.admin_role.split(',') if user.admin_role.present?
			roles.each do |r|
				user.add_role r
			end if roles.present? && roles.any?

			roles = user.frontend_role.split(',') if user.frontend_role.present?
			roles.each do |r|
				user.add_role r
			end if roles.present? && roles.any?
		end
	end

	desc "Load user roles"
	task load_user_roles: :environment do
		Rhinoart::User::ADMIN_PANEL_ROLES.each do |role|
			Role.create!(name: role) if !Role.find_by_name(role)
		end

		Rhinoart::User::FRONTEND_ROLES.each do |role|
			Role.create!(name: role) if !Role.find_by_name(role)
		end
	end
end