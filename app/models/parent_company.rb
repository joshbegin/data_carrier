class ParentCompany < ActiveRecord::Base

  validates :name, presence: true,
                  uniqueness: true
end
