class State < ActiveRecord::Base
  has_many :companies
  has_many :contacts
end
