class Product < ApplicationRecord
	has_and_belongs_to_many :stores
	has_and_belongs_to_many :order

	validates :name, length: { maximum: 250 }, presence: true
	validates :sku, length: { maximum: 250 }, presence: true
	validates :type, length: { maximum: 250 }, presence: true
	validates :price, presence: true
end
