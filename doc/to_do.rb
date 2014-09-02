General Feed Information
:name
:company_id
:feed_type_id
:transaction_type
:feed_status_id

Additional Feed Information
:feed_frequency_id
:stage_feed_url,
:production_feed_url,
:production_start_date,
:production_end_date

Partner Connections
:partner,
:split_by_data_rail

DataRail/DataView
:sent_to_data_rail,
:enhanced_carrier_status,
:data_rail_api_key,
:data_rail_password,
:data_rail_queue_priority,
:data_view_username,
:data_view_password

Notes
:notes

Contacts
:contact_id (need to remove and add has_and_belongs_to_many)

Add Source System Type - DR, Carrier, Partner, AMS, iGO
Add Source Transmission Type - FTP, SFTP, FTPS, SOAP Web Service, RESTful Web Service, Folder, anything else?
Add Destination System Type - DR, AMS, Partner, Carrier, iGO
Add Destination Transmission Type - FTP, SFTP, SOAP Web Service, RESTful Web Service, Folder,
Add parent_feed_id:integer
Remove Contact_id

rails g model SystemType name
rails g model TransmissionType name
rails g migration add_source_and_destination_fields_to_feeds source_system_type_id:int destination_system_type_id:int source_transmission_type_id:int destination_transmission_type_id:int parent_feed_id:int
rails g migration remove_contact_id_from_feeds

# Source and Destination System relations
class Feed < ActiveRecord::Base
  belongs_to :source_system_type, class_name: 'SystemType',
                              foreign_key: 'source_system_type_id'
  belongs_to :destination_system_type, class_name: 'SystemType',
                              foreign_key: 'destination_system_type_id'
end

class SystemType < ActiveRecord::Base
  has_many :source_type_feeds, class_name: 'Feed',
                            foreign_key: 'source_system_type_id'
  has_many :destination_type_feeds, class_name: 'Feed',
                            foreign_key: 'destination_system_type_id'
end

# Source and Destination Transmission relations
class Feed < ActiveRecord::Base
  belongs_to :source_transmission_type, class_name: 'TransmissionType',
                              foreign_key: 'source_transmission_type_id'
  belongs_to :destination_transmission_type, class_name: 'TransmissionType',
                              foreign_key: 'destination_transmission_type_id'
end

class TransmissionType < ActiveRecord::Base
  has_many :souce_transmission_type_feeds, class_name: 'Feed',
                            foreign_key: 'source_transmission_type_id'
  has_many :destination_transmission_type_feeds, class_name: 'Feed',
                            foreign_key: 'destination_transmission_type_id'
end

#Child/Parent Self Relations
class Feed < ActiveRecord::Base
  has_many :child_feeds, class_name: "Feed",
                          foreign_key: "parent_feed_id"

  belongs_to :parent_feed, class_name: "Feed"
end

#8-4-14
# Add Index page for Partner Connection Feeds? Add a filter to the main page?

Contacts
Feeds has_many Contacts through feed_contacts
Contacts index page (list of all contacts)
assign contacts to feeds through additional form (ajax form?)
rails g model Gender name
rails g model ContactType name
rails g scaffold Contact first_name last_name phone address_line_1 address_line_2 address_line_3 email gender_id:integer title notes:text
 (Business, Technical, Support, Internal, etc...)
rails g model FeedContact feed_id:integer contact_id:integer contact_type:integer start_date:datetime end_date:datetime

# 8-31-14
# Figure out how to get JS delete working for embedded tables (currently it deletes, but doesn't refresh the page)

