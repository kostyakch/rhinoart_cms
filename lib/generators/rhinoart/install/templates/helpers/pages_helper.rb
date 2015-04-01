module PagesHelper
	def article_list(parent, per_page = 20)
		if parent.present? && (parent.ptype == 'article' || parent.ptype == 'blog')
			Rhinoart::Page.where("parent_id = ? AND active = ? AND publish_date <= ?", parent.id, true, Time.now)
				.order('publish_date DESC, position ASC')
				.paginate(:page => params[:page], :per_page => per_page)
		else
			[]
		end		
	end
	
	def breadcrumbs(cur_page)
		page = Rhinoart::Page.find_by_slug(cur_page.slug)
		if page.present?
			if page.parent_id.present?
				[] << Rhinoart::Page.find_by_id(page.parent_id) << page
			else
				[] << page
			end
		else
			[]
		end
	end

end