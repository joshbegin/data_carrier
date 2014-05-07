class Company < ActiveRecord::Base
  belongs_to :parent_company
  belongs_to :company_type
  belongs_to :state
end
