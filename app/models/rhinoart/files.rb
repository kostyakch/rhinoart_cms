module Rhinoart
	class Files < ActiveRecord::Base
		self.inheritance_column = "non_sti"

		belongs_to :attachable, polymorphic: true

		validates :file, presence: true

		FILE_TYPE_PAGE_FILED = "page_filed"
		FILE_TYPES = local_constants.select { |const| const.to_s.starts_with? "VFILE_TYPE_" }		

		mount_uploader :file, FileUploader

		def self.files_by_type(type)
			where parent_type: type
		end

		def file_url
			file.try(:url)
		end		
	end
end
