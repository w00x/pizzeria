require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  describe "GET /api/v1/orders" do
    it "works! (now write some real specs)" do
      get api_v1_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
