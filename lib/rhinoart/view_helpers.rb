module Rhinoart
  module ViewHelpers
    extend ActiveSupport::Autoload

    eager_autoload do

      autoload :SessionHelper
      autoload :ApplicationHelper
      autoload :MenuHelper
      autoload :PagesHelper
      autoload :UsersHelper

    end

  end
end