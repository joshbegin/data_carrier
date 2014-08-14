class FeedContact < ActiveRecord::Base
  validates :feed_id, :contact_id, :contact_type_id, presence: true

  belongs_to :feed
  belongs_to :contact
  belongs_to :contact_type

end
