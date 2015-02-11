require_dependency "rhinoart/application_controller"

module Rhinoart
	class CachesController < BaseController
		def clear
			begin
				FileUtils.rm_rf(Dir['tmp/cache/[^.]*'])	
			rescue Exception => e
				flash[:info] = e.message
			end
			
			redirect_to params[:redirect_to] ||= root_path
		end
	end
end
