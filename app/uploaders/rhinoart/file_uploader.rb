# encoding: utf-8
module Rhinoart
    class FileUploader < CarrierWave::Uploader::Base
        # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
        # include Sprockets::Helpers::RailsHelper
        # include Sprockets::Helpers::IsolatedHelper

        # Choose what kind of storage to use for this uploader:
        storage :file
        # storage :fog

        # Override the directory where uploaded files will be stored.
        # This is a sensible default for uploaders that are meant to be mounted:
        def store_dir
          #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
          "uploads/files/#{model.page.id}"
        end

        def filename
            if original_filename
                original_filename.strip
                original_filename.downcase
            end
        end
    end
end
