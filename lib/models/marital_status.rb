class MaritalStatus < ActiveFileMan::Base
  fm_field :name, :free_text
  fm_field :abbreviation, :free_text
  fm_field :marital_status_code, :set
end