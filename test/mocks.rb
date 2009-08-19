class FMPatientFactory
  include Mocha::Standalone
  
  def mock_patient
    mock('FM Patient') do |variable|
      stubs(:name).returns('PATIENT,LABORATORY')
      stubs(:sex).returns('MALE')
    end
  end
end