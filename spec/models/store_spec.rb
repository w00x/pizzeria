require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should have_and_belong_to_many(:products) }

  it { should validate_length_of(:name).is_at_most(250).on(:create) }
  it { should validate_length_of(:address).is_at_most(1000).on(:create) }
  it { should validate_length_of(:phone).is_at_most(250).on(:create) }

  it "set default email in case of blank" do
  	expect(Store.create().email).to eq('francisco.abalan@pjchile.com')
  end
end
