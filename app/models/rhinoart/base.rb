module Rhinoart
	class Base < ActiveRecord::Base
		self.abstract_class = true

		def last_version_change_user
			if translation.versions.last.present?
				User.find translation.versions.last.whodunnit.to_i
			end
		end

		def last_version_change_date
			if translation.versions.last.present?
				translation.versions.last.created_at
			end
		end
			
		private
			def update_page_date
				begin
					self.page.updated_at = DateTime.now
					self.page.save
				rescue Exception => e
					logger.error "update_page_date error: #{e}" 					
				end
			end	
	end
end
