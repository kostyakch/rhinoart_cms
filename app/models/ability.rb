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
                        can :manage, :settings
                    end
                
                    begin
                        # Content managers
                        if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_CONTENT_CREATOR)
                            can :manage, :create_docs
                            can :manage, :books
                        end
                        if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_CONTENT_EDITOR)
                            can :manage, :edit_docs
                            can :manage, :books
                        end
                        if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_CONTENT_PUBLISHER)
                            can :manage, :public_docs
                            can :manage, :books
                        end
                        
                        # if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_BOOK_MANAGER)
                        #     can :manage, :books
                        # end
                        # if user.has_admin_role?(Rhinoart::User::ADMIN_PANEL_ROLE_BOOK_AUTHOR)
                        #     can :manage, :books
                        #     can :access, :sign_books
                        # end
                    rescue                        
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
