FactoryBot.define do
  factory :product do
    name { Faker::Food.dish }
    sku { Faker::IDNumber.valid }
    type { ["Pizza", "Complement"].sample }
    price { Faker::Commerce.price }

    order
  end
end