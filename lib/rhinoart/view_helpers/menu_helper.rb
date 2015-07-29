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

      def work_link(work)
        link = Rhinoart::WORK_LINKS[work.item_type] || Rhinoart::WORK_LINKS['Default']
        (link.is_a?(Proc) ? instance_exec(work, &link.to_proc) : link).to_s.html_safe
      end

    end
  end
end