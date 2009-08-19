require 'time' # needed to get the Time.parse method 
class VitalSign
  attr_accessor :kind, :value, :date
  
  def initialize(kind, value, date )
      @kind, @value, @date  = kind, value, date
    end
  
  def self.find_vital_signs_by_patient_ien(ien)
    rpc = Vista::RPC.new("ORRC VITALS BY PATIENT", ien, "20000101000000", Time.new.strftime('%Y%M%d%H%M%S'), "1")
    results = rpc.execute
    vitals = []
    current_date = nil
    (0...results.size).each do |i|     
      res = results[i]
      if(res.match /Item=*/)
          current_date = to_date(res)
        else
        vitals << create_vital_sign_from_vista_string(res, current_date)
      end
    end
    vitals.compact #just incase there is a nil in there, found one before
  end
  
  def self.create_vital_sign_from_vista_string(vista_string,current_date)
   
    
    case vista_string
   
    when /Data=B\/P\^(\d+)\/(\d+).*/
      VitalSign.new(:blood_pressure, {:systolic => $1, :diastolic => $2},current_date)
    when /Data=Ht\.\^(\d+)\^(cm|in).*/
      VitalSign.new(:height, {:value => $1, :unit => $2},current_date)
    when /Data=Temp\.\^([\d\.]+)\^(F|C).*/
      VitalSign.new(:temperature, {:value => $1, :unit => $2},current_date)
    when /Data=Wt\.\^([\d\.]+)\^(lb|kg).*/
      VitalSign.new(:weight, {:value => $1, :unit => $2},current_date)
    end
  end
  
  def self.to_date(vdate)
   
    date =  vdate.split("^").last
    date.slice!(0)
    date = "20" + date
    date.gsub!(".","")
    Time.parse date
  end
 
  
end