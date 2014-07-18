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
  validate :validate_parent_feed, :validate_parent_feed_company

  scope :recently_updated, ->(num) { order('updated_at DESC').limit(num) }
  scope :sort_by_company, -> { order('companies.name', 'feeds.name').includes(:company) }

  def name_with_company
    company.name + " - " + name
  end

  private

    def validate_parent_feed
      if self.try(:parent_feed) == self
        errors.add(:parent_feed_id, "can't be equal to Feed")
      end
    end

    def validate_parent_feed_company
      unless self.parent_feed_id.nil?
        if self.parent_feed.company != self.company
          errors.add(:parent_feed_id, "must have the same Company")
        end
      end
    end
end
