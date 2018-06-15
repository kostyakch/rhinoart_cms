# == Schema Information
#
# Table name: rhinoart_files
#
#  id                :integer          not null, primary key
#  attachable_id     :integer
#  attachable_type   :string(255)
#  file              :string(255)
#  file_content_type :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

module Rhinoart
  class Files < ActiveRecord::Base
    self.inheritance_column = 'non_sti'

    belongs_to :attachable, polymorphic: true

    validates :file, presence: true

    FILE_TYPE_PAGE_FILED = 'page_filed'.freeze
    FILE_TYPES = local_constants.select { |const| const.to_s.starts_with? 'VFILE_TYPE_' }

    mount_uploader :file, FileUploader

    def self.files_by_type(type)
      where parent_type: type
    end

    def file_url
      file.try(:url)
    end
  end
end
