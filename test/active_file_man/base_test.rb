require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

# Class that the tests will run on
class Foo < ActiveFileMan::Base
  fm_field :name, :free_text
  fm_field :date_of_birth, :date
end


class BaseTest < Test::Unit::TestCase
  context 'ActiveFileMan::Base' do
    context 'when defining the file structure' do
      should 'allow for the creation of an attribute' do
        foo = Foo.new
        foo.respond_to?(:date_of_birth)
      end
      
      should 'return the correct file name based on the class name' do
        assert_equal 'FOO', Foo.file_name
        
        class TwoWords < ActiveFileMan::Base
        end
        
        assert_equal 'TWO WORDS', TwoWords.file_name
      end
      
    end
    
    context 'when querying for objects' do
      should 'properly build a query' do
        query = mock('Query') do
          expects(:add_field).with("NAME", FMField::FIELDTYPE::FREE_TEXT)
          expects(:add_field).with("DATE OF BIRTH", FMField::FIELDTYPE::DATE)
        end
        
        Foo.build_query(query)
      end
      
      should 'properly extract the results returned from VistA' do
        result = mock('Result') do
          expects(:get_value).with("NAME").returns("STEVE")
          expects(:get_value).with("DATE OF BIRTH").returns("1234")
        end
        
        model = mock('Model') do
          expects(:name=).with("STEVE")
          expects(:date_of_birth=).with("1234")
        end
        
        Foo.build_object_from_results(model, result)
      end
    end
  end
end