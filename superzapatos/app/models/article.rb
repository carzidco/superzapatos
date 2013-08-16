class Article < ActiveRecord::Base
  attr_accessible :description, :name, :price, :store_id, :total_in_shelf, :total_in_vault
  belongs_to :store
  validates_presence_of :description, :name, :price, :store_id, :total_in_shelf, :total_in_vault
end
