class ContactType < ActiveRecord::Base
  has_many :feed_contacts
end
