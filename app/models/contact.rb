class Contact < ActiveRecord::Base
  has_paper_trail

  has_many :feed_contacts
  has_many :feeds, through: :feed_contacts
  belongs_to :gender
  belongs_to :state

  validates :first_name, :last_name, presence: true

  def full_name
    first_name + ' ' + last_name
  end
end
