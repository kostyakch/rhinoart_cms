require_dependency "rhinoart/application_controller"

module Rhinoart
	class FileworksController < ApplicationController
		require File.expand_path("../../../uploaders/rhinoart/redactor_uploader", __FILE__) 
		
		def upload_image
			RedactorUploader.configure do |config|
				config.store_dir = 'uploads/images/pages'
			end				
			uploader = RedactorUploader.new
			uploader.store!(params[:file])
			
			render json: { filelink: uploader.url }
		end

		def upload_file
			RedactorUploader.configure do |config|
				config.store_dir = 'uploads/files/pages'
			end		
			uploader = RedactorUploader.new
			uploader.store!(params[:file])

			render json: { filelink: uploader.url, filename: File.basename(uploader.url) }
		end

		def image_list
			uploader = RedactorUploader.new
			path = RedactorUploader::File.expand_path(uploader.store_dir, uploader.root)

			filesjson = []
			Dir.glob("#{path}/*").each do |f|
				filesjson << { thumb: "/#{uploader.store_dir}/#{File.basename(f)}", image: "/#{uploader.store_dir}/#{File.basename(f)}" }
				
			end
			render json: filesjson
		end
	end
end
