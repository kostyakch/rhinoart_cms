class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= Rhinoart::User.new # guest user (not logged in)
        
        if user.approved?            
            if user.admin?
                can :access, :admin_panel
                
                if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_SUPER_USER)
                    can :manage, :all
                else
                    if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_USERS_MANAGER)
                        can :manage, :users
                        cannot :manage, :user_roles
                    end
                    if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_CONTENT_MANAGER)
                        can :manage, :content
                        can :manage, :gallery
                        # can :manage, :settings
                    end
                end
            else    
                if user.frontend_user?
                    can :access, :content
                end
            end

        end
    end
end
