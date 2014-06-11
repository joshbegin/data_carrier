class ParentCompany < ActiveRecord::Base

  has_many :companies

  validates :name, presence: true,
                  uniqueness: true
end
