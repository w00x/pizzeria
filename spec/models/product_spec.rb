require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_and_belong_to_many(:stores) }
  it { should belong_to(:order) }

  it { should validate_length_of(:name).is_at_most(250).on(:create) }
  it { should validate_length_of(:sku).is_at_most(250).on(:create) }
  it { should validate_length_of(:type).is_at_most(250).on(:create) }
  it { should validate_presence_of(:price) }
end
