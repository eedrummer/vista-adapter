class Drug < ActiveFileMan::Base
  fm_field :generic_name, :free_text
  fm_field :va_classification, :free_text
  fm_field :va_product_name, :free_text
  fm_field :ndc, :free_text
  fm_field :pharmacy_orderable_item, :pointer_to_file
  
  def self.find_all
    run_query(true)
  end
end