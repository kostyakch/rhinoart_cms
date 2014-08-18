#encoding: utf-8
# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  parent_id    :integer
#  name         :string(255)      not null
#  slug         :string(255)      not null
#  position     :integer          not null
#  menu         :integer          default(1)
#  active       :boolean          default(TRUE)
#  ptype        :string(20)       default("page"), not null
#  sm_p         :string(7)        default("weekly"), not null
#  st_pr        :decimal(10, 2)   default(0.5), not null
#  created_at   :datetime
#  updated_at   :datetime
#  publish_date :date             not null
#  user_id      :integer
#
module Rhinoart
  class Page < ActiveRecord::Base
    require "rhinoart/utils"
    
    before_validation :name_to_slug
    after_initialize :set_publish_date   


    # Associations
    #has_many :page_content, :order => 'position', :autosave => true, :dependent => :destroy  
    has_many :page_content, -> { order 'position' }, :autosave => true, :dependent => :destroy  
    accepts_nested_attributes_for :page_content, :allow_destroy => true

    #has_many :page_field, :order => 'position', :autosave => true, :dependent => :destroy
    has_many :page_field, -> { order 'position' }, :autosave => true, :dependent => :destroy
    accepts_nested_attributes_for :page_field, :allow_destroy => true

    has_many :page_comment,  -> { order 'id' }, :autosave => true, :dependent => :destroy
    accepts_nested_attributes_for :page_comment, :allow_destroy => true 

    belongs_to :user#, polymorphic: true
    accepts_nested_attributes_for :user #, :allow_destroy => true

    # Validations
    validates :name, :slug, :menu, :publish_date, presence: true

    validates :name, length: { maximum: 255 }
    validates :slug, length: { maximum: 100 }

    #VALID_SLUG_REGEX = %r{^([-_/.A-Za-z0-9А-Яа-я]*|/)$}
    VALID_SLUG_REGEX = /\A[-_.\/A-Za-z0-9А-Яа-я]+\z/i
    validates :slug, uniqueness: { case_sensitive: false }, format: { with: VALID_SLUG_REGEX }
    validates_uniqueness_of :slug, :scope => :parent_id

    default_scope { order 'position asc' }
    acts_as_list  :scope => [:parent_id] #, :publish_date




    def content_by_name(name='main_content')
      if self.page_content.find_by(name: name).present?
        self.page_content.find_by(name: name).content 
      else
        ''
      end
    end
    alias_method :content, :content_by_name

    def field_by_name(name)
      field = self.page_field.find_by(name: name)
      if field.present?
        if field.ftype != PageField::FIELD_TYPES[:file].downcase
          field.value 
        else
          field.attachment.try(:file_url)
        end
      else
        ''
      end
    end
    alias_method :field, :field_by_name

    def field_obj(name)
      self.page_field.find_by(name: name) if self.page_field.find_by(name: name).present?
    end

    def children(active = true)
      if active
        Page.where('parent_id = ? AND active = true', self.id)
      else
        Page.where('parent_id = ?', self.id)
      end
    end

    def title
      if self.field_by_name('title').present?
        self.field_by_name('title')
      else
        self.name
      end
    end

    def parent
      Page.find(self.parent_id) if self.parent_id.present?
    end

    def comment_count
      PageComment.where('page_id = ? AND approved = true', self.id).count
    end 

    def self.article_list(id = nil)
      if id.present?
        self.where("ptype != 'article' AND id != ?", id).order('name')
      else
        self.where("ptype != 'article'").order('name')        
      end        
    end 


    protected
      def set_publish_date
        self.publish_date = Time.now if !self.publish_date.present?
      end

      def name_to_slug
        if !self.slug.present?
          if self.parent_id.present?
            parent = Page.find_by_id(self.parent_id)
            self.slug = parent.slug + "/" + Rhinoart::Utils.to_slug(self.name)
          else
            self.slug = Rhinoart::Utils.to_slug(self.name)
          end
        else
          self.slug = Rhinoart::Utils.to_slug(self.slug)
        end
      end

    class << self

      def find_by_path(path)
        self.where('slug = ? and active = ? and publish_date <= ?', path, true, Time.now).first
      end




    end


  end
end