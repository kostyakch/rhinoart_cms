module Rhinoart
  module Menu
    class Item

      attr_accessor :icon, :label, :link, :allowed, :active, :params

      def initialize(params = {})
        params.each{|k,v| self.send("#{k}=", v) if self.respond_to?("#{k}=")}
        self.params = params.symbolize_keys
      end

    end
  end
end