class Race < ActiveFileMan::Base
  fm_field :name, :free_text
  fm_field :abbreviation, :free_text
  fm_field :hl7_value, :free_text
  fm_field :cdc_value, :free_text
end