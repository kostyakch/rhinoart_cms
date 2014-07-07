require_dependency "rhinoart/application_controller"

module Rhinoart
	class PageFieldsController < BaseController
		def new
		end

		def create
			@field = PageField.new(admin_page_params)

			respond_to do |format|
				if @field.valid?
					format.js { }
				else
					format.js { }
				end
			end	
		end

	    def destroy
	    	begin
	            @field = PageField.find(params[:id])
	    		@field.destroy
	    	rescue
	    	end        

	        respond_to do |format|
	            format.js { }
	        end
	    end

	    def upload_image
			FieldUploader.configure do |config|
				config.store_dir = 'uploads/images/pages'
			end
							
			uploader = FieldUploader.new
			uploader.store!(params[:file])
			
			render json: { filelink: uploader.url }
		end

	    private
	        # Never trust parameters from the scary internet, only allow the white list through.
	        def admin_page_params
	            params.require(:page_field).permit!
	        end 	
	end
end
