# encoding: utf-8
module Rhinoart
	class ImageUploader < CarrierWave::Uploader::Base

		# Include RMagick or MiniMagick support:
		# include CarrierWave::RMagick
		# include CarrierWave::MiniMagick

		include CarrierWave::MiniMagick

		# Choose what kind of storage to use for this uploader:
		storage :file

		def store_dir
			"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
		end

		version :large do
			process :resize_to_limit => [736, nil]
		end

		version :thumb do
			process resize_to_fill: [120, 120]
		end	

		def extension_white_list
			%w(jpg jpeg gif png)
		end

		def filename
			"#{secure_token(8)}.#{file.extension}" if original_filename
		end

		# def filename
		#   if original_filename
		#     original_filename.gsub! /\s*[^A-Za-z0-9\.\/]\s*/, '_'
		#     original_filename.strip
		#     original_filename.downcase
		#   end
		# end

		protected
			def secure_token(length = 16)            
				var = :"@#{mounted_as}_secure_token"
				model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
			end 
	end
end
