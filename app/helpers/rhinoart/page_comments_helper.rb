module Rhinoart
	module PageCommentsHelper
		def children_blog_comments(parent)
			PageComment.paginate(page: params[:page]).where("parent_id = #{parent.id}")
		end
	end
end
