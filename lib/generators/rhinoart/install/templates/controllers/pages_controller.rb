class PagesController < ApplicationController

  layout 'pages'

  def index
    @page = Rhinoart::Page.find_by_path('index')
    render text: @page.content, layout: true
  end

  def internal
    @page = Rhinoart::Page.find_by_path(params[:url])
    render text: @page.content, layout: true
  end

end