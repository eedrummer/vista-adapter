require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

# Class that the tests will run on
class Bar < ActiveFileMan::Base
  fm_field :name, :free_text
  
  has_one :toothbrush
end

class Toothbrush
  def self.find_by_ien(ien)
    "toothbrush #{ien}"
  end
end

class AssociationsTest < Test::Unit::TestCase
  context 'ActiveFileMan::Base' do
    context 'when defining pointers to files' do
      should 'add a find_ method to the class' do
        b = Bar.new
        assert b.respond_to?(:find_toothbrush)
      end
      
      should 'add an property to hold the file pointer' do
        b = Bar.new
        assert b.respond_to?(:toothbrush)
        assert b.respond_to?(:toothbrush=)
      end
    end
    
    context 'when following the file pointer' do
      should 'call find_by_ien on the associated class' do
        b = Bar.new
        b.toothbrush = '7'
        assert_equal 'toothbrush 7', b.find_toothbrush
      end
    end
  end
end