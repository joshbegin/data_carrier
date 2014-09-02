class Contact < ActiveRecord::Base
  has_paper_trail

  has_many :feed_contacts
  has_many :feeds, through: :feed_contacts
  belongs_to :gender
  belongs_to :state

  validates :first_name, :last_name, presence: true

  accepts_nested_attributes_for :feed_contacts, :reject_if => :all_blank
  accepts_nested_attributes_for :feeds, :reject_if => :all_blank
  
  def full_name
    first_name + ' ' + last_name
  end
end
