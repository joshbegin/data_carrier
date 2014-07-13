class Feed < ActiveRecord::Base
  has_paper_trail
  belongs_to :company
  belongs_to :feed_status
  belongs_to :feed_frequency
  belongs_to :feed_type
  belongs_to :source_system_type, class_name: 'SystemType', foreign_key: 'source_system_type_id'
  belongs_to :destination_system_type, class_name: 'SystemType', foreign_key: 'destination_system_type_id'
  belongs_to :source_transmission_type, class_name: 'TransmissionType', foreign_key: 'source_transmission_type_id'
  belongs_to :destination_transmission_type, class_name: 'TransmissionType', foreign_key: 'destination_transmission_type_id'
  has_many :child_feeds, class_name: "Feed", foreign_key: "parent_feed_id"
  belongs_to :parent_feed, class_name: "Feed"

  validates :name, presence: true, uniqueness: true
  validates :company_id, :feed_type_id, :feed_status_id, presence: true

  scope :recently_updated, ->(num) { order('updated_at DESC').limit(num) }
  scope :sort_by_company, -> { order('companies.name', 'feeds.name').includes(:company) }
end
