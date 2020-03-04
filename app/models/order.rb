class Order < ApplicationRecord
  belongs_to :store
  has_many :products

  def total
  	return self.products.map(&:price).sum
  end
end
