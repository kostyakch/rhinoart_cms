module Rhinoart
	class Base < ActiveRecord::Base
		self.abstract_class = true

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
