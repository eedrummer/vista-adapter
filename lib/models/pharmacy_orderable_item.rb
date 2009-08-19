class PharmacyOrderableItem < ActiveFileMan::Base
  fm_field :ien, :free_text
  fm_field :name, :free_text
  fm_field :dosage_form, :pointer_to_file
  
  def self.find_all
    run_query(true) do |query|
      query.get_field('DOSAGE FORM').internal = false
    end
  end
end