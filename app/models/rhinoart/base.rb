module Rhinoart
  class Base < ActiveRecord::Base
    self.abstract_class = true

    def last_version_change_user
      if translation.versions.last.present?
        begin
          User.find translation.versions.last.whodunnit.to_i
        rescue StandardError
        end
      end
    end

    def last_version_change_date
      translation.versions.last.created_at if translation.versions.last.present?
    end

    def can_edit?(locale = nil)
      exists_statuses = if locale.present?
                          statuses.where(locale: locale)
                        else
                          statuses
      									end

      if exists_statuses.count == 0 && (Rhinoart::User.current.can?(:manage, :create_docs) || Rhinoart::User.current.can?(:manage, :edit_docs) || Rhinoart::User.current.can?(:manage, :public_docs))
        true
      elsif exists_statuses.count == 1 && (Rhinoart::User.current.can?(:manage, :edit_docs) || Rhinoart::User.current.can?(:manage, :public_docs))
        true
      elsif Rhinoart::User.current.can?(:manage, :public_docs)
        true
      else
        false
      end
    end

    private

    def update_page_date
      page.updated_at = DateTime.now
      page.save
      rescue Exception => e
        logger.error "update_page_date error: #{e}"
      end
  end
end
