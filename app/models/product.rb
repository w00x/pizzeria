class Product < ApplicationRecord
	has_and_belongs_to_many :stores
	belongs_to :order
end
