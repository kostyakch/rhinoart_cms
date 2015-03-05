module Rhinoart
  module Menu
    class Base
      include Singleton

      class << self
        include Rails.application.routes.url_helpers
        include Rails.application.routes.mounted_helpers
      end

      attr_accessor :items

      def add_item(params = {})
        self.items ||= []
        self.items << item_class.new(params)
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