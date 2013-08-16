class Store < ActiveRecord::Base
  attr_accessible :address, :name
  has_many :articles
  validates_presence_of :address, :name
end
