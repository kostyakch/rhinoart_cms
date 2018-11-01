# frozen_string_literal: true

namespace :db do
  desc 'Fill database with admin user data'
  task populate: :environment do
    user = Rhinoart::User.create!(
      name: 'Admin User',
      email: 'admin@test.com',
      approved: 1,
      password: 'admin',
      password_confirmation: 'admin'
    )

    Rhinoart::User::ADMIN_PANEL_ROLES.each do |role|
      Role.create!(name: role) unless Role.find_by(name: role)
    end
    Rhinoart::User::FRONTEND_ROLES.each do |role|
      Role.create!(name: role) unless Role.find_by(name: role)
    end

    user.add_role Rhinoart::User::ADMIN_PANEL_ROLE_SUPER_USER
    user.add_role Rhinoart::User::ADMIN_PANEL_ROLE_USERS_MANAGER
  end
end
