class Order < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :products

  def total
  	return self.products.map(&:price).sum
  end
end
