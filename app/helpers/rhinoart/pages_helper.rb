#encoding: utf-8
module Rhinoart
	module PagesHelper
		def page_items(parent = nil)
			if parent.blank?
				Page.paginate(page: params[:page]).where('parent_id IS NULL')	
			else
				Page.paginate(page: params[:page]).where('parent_id = ?', parent.id) if parent.ptype == 'page'
			end		
		end	

		def page_tree(parent = nil)
			if parent.blank?
				Page.where("parent_id IS NULL and active = ?", true)	
			else
				Page.where('parent_id = ? and active = ?', parent.id, true) if parent.ptype == 'page'
			end		
		end	

		def disabled_page?(page)
			if page.present? 
				setting_by_name('disabled_pages').split(',').include? page.id.to_s if setting_by_name('disabled_pages').present?
			end
		end

		def field_javascript
			<<-CODE
			$(function(){
				// Удаление параметра
				$('.del_field').click(function() {
					var row = $(this).parent().parent().parent();
					row.remove();
					return false;
				});	
			})
			CODE
		end

		def tab_javascript
			<<-CODE		
			$(function(){
				// добавление таба дополнительного контента
				var tabCount = $('#tabs li').length -1;
				$('#add_content').click(function() {
					var addContentName = prompt ("Введите наименование параметра","");
					if(addContentName == null || addContentName == '' || addContentName.length < 3) {
						alert('Наименование не заполнето или содержит мешьше 3-х символов');
						return false;
					}

					var html_tab  = '<li><input id="page_page_content_attributes___name___name" name="page[page_content_attributes][__name__][name]" type="hidden" value="'+addContentName+'">'+
									'<a href="#form_contents_add___name___name_tab" data-toggle="tab" rel="form_contents_add___name___name_tab">'+addContentName+' <i class="icon-remove-sign del_tab"></i></a>'+
									'</li>';
					var html_content = '<div class="tab-pane" id="form_contents_add___name___name_tab">'+
									'<textarea cols="40" id="page_page_content_attributes___name___content" name="page[page_content_attributes][__name__][content]" rows="20"></textarea>'+
									'<script type="text/javascript">$(".tab-pane > textarea").redactor({minHeight: 350, imageUpload: "#{upload_image_path}", imageGetJson: "#{image_list_path}", fileUpload: "#{upload_file_path}"});</script>'+
									'</div>';

					html_tab     = html_tab.replace(/__name__/g, tabCount);
					html_content = html_content.replace(/__name__/g, tabCount);
					tabCount++;

					$('#tabs').append(html_tab);
					$('.tab-content').append(html_content);
					return false;
				});	

				// Удаление таба дополнительного контента
				$('.del_tab').click(function() {
					var delrow = $(this).parent().parent();
					var parentId = $(this).parent().attr('rel');

					if(confirm('Вы уверены что хотите удалить вкладку дополнительного контента?')) {
						$('.tab-content #'+parentId).remove();
						delrow.remove();
						return false;
					}

					return false;
				});	
			})	
			CODE
		end

	end
end
