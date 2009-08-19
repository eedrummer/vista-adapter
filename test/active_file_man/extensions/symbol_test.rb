require File.expand_path(File.dirname(__FILE__) + '/../../test_helper')

class SymbolTest < Test::Unit::TestCase
  context 'Symbol' do
    should 'be able to create a FileMan name for itself' do
      assert_equal 'DATE OF BIRTH', :date_of_birth.to_file_man_name
      assert_equal 'FOO', :foo.to_file_man_name
    end
    
    should 'be able to create a class from itself' do
      assert_equal String, :string.to_class
    end
    
  end
end