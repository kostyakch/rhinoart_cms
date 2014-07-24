module Rhinoart
    class NotificationsMailer < ActionMailer::Base
        default from: Rails::configuration.action_mailer.default_url_options.present? ? Rails::configuration.action_mailer.default_url_options[:default_email] : 'no-reply@amko.pro'

        def new_user_notification(user, mail_to)
            @user = user
            mail to: mail_to, subject: "New User"        
        end

        def new_user_welcome(user)
            @user = user
            mail to: user.email, subject: "Welcome #{@user.name}!"
        end 

        def user_grant_access_notification(user)
            @user = user
            mail to: user.email, subject: "Hello #{@user.name}"
        end 

        def change_password_notification(user, unencrypted_pass)
            @user = user
            @unencrypted_pass = unencrypted_pass

            mail to: user.email, subject: "Hello #{@user.name}"
        end

        def send_contact_form(message, mail_to)
            @message = message
            mail to: mail_to, subject: "Message from Website"
        end        
    end
end
