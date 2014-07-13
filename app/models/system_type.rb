class SystemType < ActiveRecord::Base
  has_many :source_type_feeds, class_name: 'Feed',
                            foreign_key: 'source_system_type_id'
  has_many :destination_type_feeds, class_name: 'Feed',
                            foreign_key: 'destination_system_type_id'
end
