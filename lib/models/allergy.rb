class Allergy  < ActiveFileMan::Base
  
  attr_accessor :ien, :product, :reaction
  set_file_name "PATIENT ALLERGIES"
  fm_field :reactant, :free_text
  fm_field :patient, :pointer_to_file
  fm_field :reactions, :pointer_to_file
  fm_field :reaction, :pointer_to_file
  
  def initialize(ien, product, reaction)
    @ien, @product, @reaction = ien, product, reaction
  end
  
  def self.find_allergies_by_patient_ien(ien)
    rpc = Vista::RPC.new("ORQQAL LIST", ien)
    results = rpc.execute
    allergies = []
    (0...results.size).each do |i|
      allergies << create_allergy_from_vista_string(results[i])
    end
    allergies
  end
  
  def self.create_allergy_from_vista_string(vista_string)
    components = vista_string.split('^')
    ien = components[0]
    product = components[1]
    reaction = components[3]
    
    Allergy.new(ien, product, reaction)
  end
end