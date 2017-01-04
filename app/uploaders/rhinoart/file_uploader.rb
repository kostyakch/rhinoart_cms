# encoding: utf-8
module Rhinoart
    class FileUploader < CarrierWave::Uploader::Base
        # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
        # include Sprockets::Helpers::RailsHelper
        # include Sprockets::Helpers::IsolatedHelper

        # include CarrierWave::MimeTypes

        process :set_content_type
        process :save_content_type_in_model        

        def save_content_type_in_model
            model.file_content_type = file.content_type if file.content_type
        end
        
        # Choose what kind of storage to use for this uploader:
        storage :file
        # storage :fog

        # Override the directory where uploaded files will be stored.
        # This is a sensible default for uploaders that are meant to be mounted:
        def store_dir
          "uploads/#{model.class.to_s.underscore}/#{model.id}"
        end

        def filename
          "#{secure_token(10)}.#{file.extension}" if original_filename
        end

        protected
          def secure_token(length = 16)            
            var = :"@#{mounted_as}_secure_token"
            model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
          end          

    end
end
