class TransmissionType < ActiveRecord::Base
  has_many :souce_transmission_type_feeds, class_name: 'Feed',
                            foreign_key: 'source_transmission_type_id'
  has_many :destination_transmission_type_feeds, class_name: 'Feed',
                            foreign_key: 'destination_transmission_type_id'
end
