module Rhinoart
  module Menu
    class Base
      include Singleton

      attr_accessor :items

      def add_item(params = {})
        self.items ||= []
        self.items << item_class.new(params)
      end

      def prepend_item(params = {})
        self.items ||= []
        self.items.unshift item_class.new(params)
      end

      def insert(index = 0, params = {})
        self.items ||= []
        index = self.items[index].present? ? index : self.items.size
        self.items.insert index, item_class.new(params)
      end

      def self.add_item(params)
        self.instance.add_item(params)
      end

      def self.items
        self.instance.items || []
      end

      private

      def item_class
        Rhinoart::Menu::Item
      end

    end
  end
end