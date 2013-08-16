class Store < ActiveRecord::Base
  attr_accessible :address, :name
  has_many :articles
end
