class ParentCompany < ActiveRecord::Base
  has_paper_trail

  has_many :companies

  validates :name, presence: true,
                  uniqueness: true

  scope :recently_updated, ->(num) { order('updated_at DESC').limit(num) }
end
