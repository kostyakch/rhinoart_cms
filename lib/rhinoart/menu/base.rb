module Rhinoart
  module Menu
    class Base
      include Singleton

      attr_accessor :items

      def self.add_item(params = {})
        self.instance.items ||= []
        self.instance.items << self.instance.item_class.new(params)
      end

      def self.unshift_item(params = {})
        self.items ||= []
        self.items.unshift self.instance.item_class.new(params)
      end

      def self.insert(index = 0, params = {})
        self.instance.items ||= []
        index = self.items[index].present? ? index : self.items.size
        self.items.insert index, self.instance.item_class.new(params)
      end

      def self.items
        self.instance.items ||= []
      end

      def item_class
        Rhinoart::Menu::Item
      end

    end
  end
end