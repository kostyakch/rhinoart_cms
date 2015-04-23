module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = setting_by_name('site_name') ? setting_by_name('site_name') : 'Rhino Rails CMS'
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	def top_menu_items(parent = nil)
		if parent.blank?
			Rhinoart::Page.where(active: true, menu: true, parent_id: nil).order(:position)
		else
			Rhinoart::Page.where(active: true, menu: true, parent_id: parent.id).order(:position) if parent.ptype == 'page'
		end		
	end

	def meta_tags(page)
		res = "<!-- (c) RhinoArt | http://www.rhinoart.ru/ / -->\n"
		if page and page.page_field
			page.page_field.where("ftype = 'meta' and ftype is not null").each do |meta|
				res += "<meta name=\"#{meta.name}\" content=\"#{meta.value}\" />\n"
			end
		end

		raw res		
	end  

	def render_partial_if_exists(partial)
		render partial: partial
		
		# rescue
		# 	t('_PARTIAL_ERROR', name: partial)

	end

	def setting_by_name(name, reload = false)
		if !reload && session[:"setting_#{name}"].present?
			session[:"setting_#{name}"]
		else
			setting = Rhinoart::Setting.find_by_name(name)
			session[:"setting_#{name}"] = setting.value if setting.present?
		end
	end 

	def resource_name
		:user
	end

	def resource
		@resource ||= Rhinoart::User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end		
end
