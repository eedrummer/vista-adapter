require 'models/marital_status'
class Patient < ActiveFileMan::Base
  fm_field :name, :free_text
  fm_field :sex, :set
  fm_field :dob, :date
  fm_field :enterprise_patient_identifier, :computed
  fm_field :id,:computed
  fm_field :admitting_physician,:computed
  fm_field :admitting_diagnosis,:computed
  fm_field :attending_physician,:pointer_to_file
  fm_field :provider, :pointer_to_file
  
  fm_field "PLACE OF BIRTH  [CITY]", :free_text, :pob_city
  fm_field "PLACE OF BIRTH [STATE]", :free_text, :pob_state
 
  fm_field "STREET ADDRESS [LINE 1]" , :free_text, :street_address_1
  fm_field "STREET ADDRESS [LINE 2]" , :free_text, :street_address_2
  fm_field "STREET ADDRESS [LINE 3]" , :free_text, :street_address_3
  
  fm_field "CITY" , :free_text, :city
  fm_field "STATE" , :free_text, :state
  fm_field "ZIP CODE" , :free_text, :zip
  fm_field "ZIP+4" , :free_text, :zip_4
  
  fm_field "EMAIL ADDRESS" , :free_text, :email
  fm_field "PAGER NUMBER" , :free_text, :pager
  fm_field "PHONE NUMBER [RESIDENCE]" , :free_text, :home_phone
  fm_field "PHONE NUMBER [WORK]" , :free_text, :work_phone
  fm_field "PHONE NUMBER [CELLULAR]" , :free_text, :cell_phone
  
  fm_field "K-NAME" , :free_text, :nok_name
  fm_field "K-RELATIONSHIP" , :free_text, :nok_relationship
  fm_field "K-STREET ADDRESS [LINE 1]" , :free_text, :nok_address_line_1
  fm_field "K-STREET ADDRESS [LINE 2]" , :free_text,  :nok_address_line_2
  fm_field "K-STREET ADDRESS [LINE 3]" , :free_text, :nok_address_line_3

  fm_field "K-CITY" , :free_text, :nok_city
  fm_field "K-STATE" , :free_text, :nok_state
  fm_field "K-ZIP" , :free_text, :nok_zip
  fm_field "K-ZIP+4" , :free_text
   
  has_one :race
  has_one :marital_status
 

  def has_address
     return street_address_1 || 
            city ||
            state         
  end
  
end