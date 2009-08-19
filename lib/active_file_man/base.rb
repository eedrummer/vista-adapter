module ActiveFileMan
  class Base
    extend Vista::ConnectionHandler
    extend ActiveFileMan::Associations
    
    @@field_types = {
      :free_text => com.medsphere.fileman.FMField::FIELDTYPE::FREE_TEXT,
      :set => com.medsphere.fileman.FMField::FIELDTYPE::SET_OF_CODES,
      :date => com.medsphere.fileman.FMField::FIELDTYPE::DATE,
      :pointer_to_file => com.medsphere.fileman.FMField::FIELDTYPE::POINTER_TO_FILE,
      :sub_file => com.medsphere.fileman.FMField::FIELDTYPE::POINTER_TO_FILE
    }
    
    def self.fm_field(field_name, field_type, accessor = nil)
      @fields ||= {}
      @field_accessors ||= {}
      @fields[field_name] = field_type
      @field_accessors[field_name] = accessor || field_name
      attr_accessor accessor || field_name
    end
    
    def self.fields
      @fields
    end
    
    def self.field_accessors
        @field_accessors
    end
    
    def self.set_file_name(name)
      @file_name = name
    end
    
    def self.file_name
      return @file_name.upcase if @file_name
      
      file_name = self.name
      
      if self.name.include?('::')
        file_name = self.name[/\:\:(\w+)$/, 1]
      end
      
      file_name.gsub!(/([a-z\d])([A-Z])/,'\1 \2')
      file_name.upcase
    end
    
    
    def self.find_by(field_name, desired_value, single=true)
      run_query(single) do |query|
        field_screen = FMScreenField.new(field_name.to_file_man_name)
        value_screen = FMScreenValue.new(desired_value)
        
        query.screen = FMScreenEquals.new(field_screen, value_screen)
      end
    end
    
    def self.find_by_ien(ien)
      run_query do |query|
        value_screen = FMScreenValue.new(ien)
        query.screen = FMScreenEquals.new(FMScreenIEN.new, value_screen)
      end
    end
    

    def self.run_query(return_multiple=false)
      return_record = nil

      with_connection do |connection|
        connection.setContext(FMUtil::FM_RPC_CONTEXT)
        adapter = RPCResAdapter.new(connection, FMUtil::FM_RPC_NAME)
        fm_file = FMFile.new(file_name)
        query = FMQueryList.new(adapter, fm_file)
        
        build_query(query)
        
        yield query if block_given?
        
        results = query.execute
        

        if return_multiple
          return_record = []
          while results.next
            object = allocate
            build_object_from_results(object, results)
            return_record << object
          end
        else
          results.next
          return_record = allocate
          build_object_from_results(return_record, results)
        end
        
      end
      
      return_record

    end
    
    def self.build_object_from_results(object, results)
      fields.each_key do |key|
         accessor = field_accessors[key] || key
        object.send((accessor.to_s + '=').to_sym, results.get_value(key.to_file_man_name))
      end      
    end
    
    def self.build_query(query)
      fields.each_pair do |field_name, field_type|
        query.add_field(field_name.to_file_man_name, @@field_types[field_type])
      end
    end
  end
end