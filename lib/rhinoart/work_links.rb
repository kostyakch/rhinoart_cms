module Rhinoart

  WORK_LINKS = {
    'Rhinoart::PageField' => proc do |work|
      obj = Rhinoart::PageField.find(work.item_id)
      "#{t'Page Field' } #{link_to obj.page.name, rhinoart.edit_page_path(obj.page, redirect_to: request.fullpath)}"
    end,

    'Rhinoart::PageContent' => proc do |work|
      obj = Rhinoart::PageContent.find(work.item_id)
      "#{t'Page Content' } #{link_to obj.page.name, rhinoart.edit_page_path(obj.page, redirect_to: request.fullpath)}"
    end,

    'Rhinobook::Book::Translation' => proc do |work|
      obj = Rhinobook::Book::Translation.find(work.item_id)
      book = Rhinobook::Book.find(obj.rhinobook_book_id)

      link_to rhinobook.edit_book_path(book, :redirect_to => request.fullpath) do
        Globalize.with_locale(obj.locale) do
          "#{t('book')}: #{book.name}"
        end
      end
    end,

    'Rhinobook::Chapter::Translation' => proc do |work|
      obj = Rhinobook::Chapter::Translation.find(work.item_id)
      chapter = Rhinobook::Chapter.find(obj.rhinobook_chapter_id)
      link_to rhinobook.edit_book_chapter_path(:book_id => chapter.book, :id => chapter, :redirect_to => request.fullpath) do
        Globalize.with_locale(obj.locale) do
          "#{t('chapter')}: #{chapter.name}"
        end
      end
    end,

    'Rhinobook::Page::Translation' => proc do |work|
      obj = Rhinobook::Page::Translation.find(work.item_id)
      page = Rhinobook::Page.find(obj.rhinobook_page_id)
      link_to rhinobook.edit_chapter_page_path(:chapter_id => page.chapter, :id => page, :redirect_to => request.fullpath) do
        Globalize.with_locale(obj.locale) do
          "#{t('page')}: #{page.num} <small>#{truncate(strip_tags(page.content), :length => 120)}</small>"
        end
      end
    end,

    'Default' => proc do |work|
      cur_object = work.item_type.constantize.find(work.item_id)
      short_class_name = cur_object.class.name.gsub(/(.*)::/, '')
      "#{t short_class_name} #{link_to cur_object.name, send("edit_#{short_class_name}_path".downcase, cur_object, redirect_to: request.fullpath)}"
    end
  }

end