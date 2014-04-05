#encoding: utf-8
require_dependency "rhinoart/application_controller"

module Rhinoart
	class PagesController < ApplicationController		
		before_action :set_rhinoart_page, only: [:edit, :update, :destroy]
		before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR] }


		def index(parent = nil)
			store_location
			if parent.blank?
				@pages = Page.paginate(page: params[:page]).where("parent_id IS NULL AND active = ?", true)	
			else
				@pages = Page.paginate(page: params[:page]).where("parent_id = ?", parent.id) if parent.ptype == 'page'
			end			
		end

		def children
			store_location

			@parent = Page.find(params[:parent_id])
			@pages = Page.where("parent_id = ?", params[:parent_id]).order('publish_date DESC')
		end

		def new
	    	@page = Page.new
	    	@pages_for_select = pages_for_select    	

	    	if params[:parent_id].present?
		    	@page.parent_id = params[:parent_id]
		       	@page.ptype = Page.find(@page.parent_id).ptype
	    	end

	    	if !@page.ptype.present?
	    		content_fields(@page)
	    		content_tabs(@page)
	    	else
		    	case @page.ptype
		    	when 'article'
		    		content_fields(@page)
		    		content_tabs(@page,  %w[main_content preview])
		    	when 'blog'
		    		fields =  [
							{ :name => "title", :ftype => "title", :position => 1 },
							{ :name => "h1", :ftype => "title", :position => 2 },
							{ :name => "description", :ftype => "meta", :position => 3 },
							{ :name => "keywords", :ftype => "meta", :position => 4 },
							{ :name => "comment", :ftype => "boolean", :position => 5, :value => 'no' },
					]
		    		content_fields(@page, fields)
		    		content_tabs(@page,  %w[short full])
		    	else
		    		content_fields(@page)
		    		content_tabs(@page)
		    	end    		
	    	end

		end

		def create
			@page = Page.new		
			@pages_for_select = pages_for_select

			if @page.update_attributes(admin_pages_params)

				flash[:info] = t('_PAGE_SUCCESSFULLY_CREATED')
				if params[:continue].present? 
					redirect_to edit_structure_path(@page)
				else
					redirect_back_or pages_path
				end			
			else	
				render 'new'
			end
		end

		def edit
			@pages_for_select = pages_for_select params[:id]
		end

		def update
			@pages_for_select = pages_for_select params[:id]
			if @page.update(admin_pages_params)
				#update_page_field(@page, params[:page]) # Обновим данные о page_field
				update_page_content(@page, params[:page])		

				flash.now[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
				if params[:continue].present? 
					render action: "edit"
				else
					redirect_back_or pages_path
				end
			else
				render action: "edit"
			end
		end

		def tree
			store_location
		end
		
		def destroy		
			page_name = @page.name
			@page.destroy

			flash[:info] = t('_PAGE_SUCCESSFULLY_DELITED', name: page_name)
			redirect_back_or pages_path
		end

		def showhide
			page = Page.find(params[:id])
			page.update_attributes( :active => !page.active? )

			redirect_back_or pages_path
		end

		def sort
			params[:page].each_with_index do |id, index|
				Page.update_all(['position=?', index+1], ['id=?', id])
			end
			render :nothing => true
		end

		def field_page_add
			@count_page = params[:count_page]
			
			@field_name = params[:field_name]
			@field_type = params[:field_type]

			field_new = [{ :name => @field_name, :ftype => @field_type, :position => @count_page }]

			@page.page_field.build(field_new)

			@field = @page.page_field.last

			#debugger

			respond_to do |format|
		    	format.js
		    end
			
		end

		private
	        # Use callbacks to share common setup or constraints between actions.
	        def set_rhinoart_page
	            @page = Page.find(params[:id])
	        end

	        # Never trust parameters from the scary internet, only allow the white list through.
	        def admin_pages_params
	            params.require(:page).permit!
	        end

			def content_tabs(page, names=%w[main_content])
				names.each_with_index do |name, i|
					page.page_content.build(name: name, position: i+1) if page.page_content.where("name = '#{name}'").empty?
				end
			end

			def content_fields(page, fields = 'default')
				if fields == 'default'
					fields =  [
							{ :name => "title", :ftype => "title", :position => 1 },
							{ :name => "h1", :ftype => "title", :position => 2 },
							{ :name => "description", :ftype => "meta", :position => 3 },
							{ :name => "keywords", :ftype => "meta", :position => 4 }
					]
				end

				fields.each do |field|
					field.assert_valid_keys(:name, :ftype, :position, :value) # валидация
					page.page_field.build(field)
				end
			end

			def update_page_field(page, params)
				originalFields = []
				page.page_field.each { |f| originalFields << f }

				# filter originalFields to contain params no longer present	
				if params[:page_field_attributes].present?	
					params[:page_field_attributes].each do |fk, fv|
						originalFields.each do |of|
							originalFields.delete(of) if of.name.to_s.downcase == fv[:name].to_s.downcase
						end
					end
				end

				originalFields.each { |f| f.destroy }
			end

			def update_page_content(page, params)
				originalTabs = []
				page.page_content.each { |f| originalTabs << f }

				# filter originalTabs to contain params no longer present	
				if params[:page_content_attributes].present?	
					params[:page_content_attributes].each do |fk, fv|
						originalTabs.each do |of|
							originalTabs.delete(of) if of.name.to_s.downcase == fv[:name].to_s.downcase
						end
					end
				end

				# remove the relationship between the param and the Content
				originalTabs.each { |f| f.destroy }			
			end

			def pages_for_select(id = nil)
				if id.present?
					Page.where("ptype != 'article' AND id != ?", id).order('name')
				else
					Page.where("ptype != 'article'").order('name')				
				end			
			end

	end
end
