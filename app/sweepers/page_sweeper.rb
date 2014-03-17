class PageSweeper < ActionController::Caching::Sweeper
  observe Page
  
  def after_save(page)
    expire_cache(page)
  end
  
  def after_destroy(page)
    expire_cache(page)
  end
  
  def expire_cache(page)
    expire_page :controller => '/pages', :action => 'index' #, :format => 'js'
    expire_page :controller => '/pages', :action => 'internal', :url => page.slug
  end
end