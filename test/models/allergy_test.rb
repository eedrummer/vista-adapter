require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class AllergyTest < Test::Unit::TestCase
  context 'Allergy' do
    should 'properly parse an allergy response string from VistA' do
      allergy = Allergy.create_allergy_from_vista_string("1^TREE NUTS^^RASH")
      assert_equal '1', allergy.ien
      assert_equal 'TREE NUTS', allergy.product
      assert_equal 'RASH', allergy.reaction
    end
  end
end