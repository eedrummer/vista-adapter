module ActiveFileMan
  module Associations
    def has_one(class_name, field_name=nil)
      field_name ||= class_name
      fm_field(field_name, :pointer_to_file)
      
      define_method(('find_' + class_name.to_s).to_sym) do
        clazz = class_name.to_class
        clazz.send(:find_by_ien, send(field_name))
      end
    end
  end
end