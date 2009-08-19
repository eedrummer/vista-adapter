require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class VitalSignTest < Test::Unit::TestCase
  context 'VitalSign' do
    should 'properly parse a blood pressure vital sign response string from VistA' do
      vital = VitalSign.create_vital_sign_from_vista_string("Data=B/P^122/82^^^^^^^", Time.now)
      assert_equal :blood_pressure, vital.kind
      assert_equal '122', vital.value[:systolic]
      assert_equal '82', vital.value[:diastolic]
    end
    
    should 'properly parse a height vital sign response string from VistA' do
      vital = VitalSign.create_vital_sign_from_vista_string("Data=Ht.^68^in^172.72^cm^^^^", Time.now)
      assert_equal :height, vital.kind
      assert_equal '68', vital.value[:value]
      assert_equal 'in', vital.value[:unit]
    end
    
    should 'properly parse a temperature vital sign response string from VistA' do
      vital = VitalSign.create_vital_sign_from_vista_string("Data=Temp.^98.6^F^37.0^C^^^^", Time.now)
      assert_equal :temperature, vital.kind
      assert_equal '98.6', vital.value[:value]
      assert_equal 'F', vital.value[:unit]
    end
    
    should 'properly parse a weight vital sign response string from VistA' do
      vital = VitalSign.create_vital_sign_from_vista_string("Data=Wt.^145^lb^65.771^kg^22^^^", Time.now)
      assert_equal :weight, vital.kind
      assert_equal '145', vital.value[:value]
      assert_equal 'lb', vital.value[:unit]
    end
  end
end