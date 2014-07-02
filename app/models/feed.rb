class Feed < ActiveRecord::Base
  has_paper_trail
  belongs_to :company
  belongs_to :feed_status
  belongs_to :feed_frequency
  belongs_to :feed_type

  validates :name, presence: true, uniqueness: true
  validates :company_id, :feed_type_id, :feed_status_id, presence: true

  scope :recently_updated, ->(num) { order('updated_at DESC').limit(num) }
end
