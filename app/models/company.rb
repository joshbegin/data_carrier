class Company < ActiveRecord::Base
  has_paper_trail
  belongs_to :parent_company
  belongs_to :company_type
  belongs_to :state
  has_many :feeds, dependent: :restrict_with_error # raises ActiveRecord::DeleteRestrictionError

  validates :name, presence: true, uniqueness: true
  validates :company_type_id, presence: true

  scope :recently_updated, ->(num) { order('updated_at DESC').limit(num) }
  scope :sort_by_name, ->  { order(:name) }
end
