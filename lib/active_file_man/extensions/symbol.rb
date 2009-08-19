module ActiveFileMan
  module Extensions
    module Symbol
      def to_file_man_name
        self.to_s.gsub('_', ' ').upcase
      end
      
      def to_class
        Object.const_get(self.to_s.capitalize)
      end
    end
  end
end

class Symbol
  include ActiveFileMan::Extensions::Symbol
end

class String
  def to_file_man_name
    self.upcase
  end
end
