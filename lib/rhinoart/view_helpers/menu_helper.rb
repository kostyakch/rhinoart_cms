#encoding: utf-8
module Rhinoart
  module ViewHelpers
    module MenuHelper

      def menu_item_active?(item)
        item.active.is_a?(Proc) ? instance_eval(&item.active.to_proc) : !!item.active
      end

      def menu_item_allowed?(item)
        item.allowed.is_a?(Proc) ? instance_eval(&item.allowed.to_proc) : !!item.allowed
      end

      def menu_item_link(item)
        item.link.is_a?(Proc) ? instance_eval(&item.link.to_proc) : item.link
      end

    end
  end
end