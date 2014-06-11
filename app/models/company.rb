class Company < ActiveRecord::Base
  belongs_to :parent_company
  belongs_to :company_type
  belongs_to :state

  validates :name, presence: true, uniqueness: true
  validates :company_type_id, presence: true
end
