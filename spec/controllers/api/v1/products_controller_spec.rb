require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }
  let(:order_id) { products.first.order_id }
  let(:stores) { create_list(:store, 5) }

  describe "GET /product" do
    before { get :index }

    it "return products list" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "return status code 200" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /product" do
    let(:valid_attributes) { { name: 'Napolitana', sku: '234124', type: 'Pizza', price: 234, order_id: order_id } }

    context "when the request is valid" do
      before { post :create, params: valid_attributes }

      it "create a product" do
        expect(json['name']).to eq('Napolitana')
        expect(json['sku']).to eq('234124')
        expect(json['price']).to eq(234)
      end

      it "return 201 code" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when the request is not valid" do
      before { post :create, params: { name: nil, sku: nil, type: nil, price: nil } }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "return a failure message" do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe "GET /product/:id" do
    before { get :show, params: {id: product_id} }

    context "when the record exist" do
      it "return the product" do
        expect(json).not_to be_empty
      end

      it "return the status code 200" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the record does not exist" do
      let(:product_id) { 100000 }

      it "return a not found message" do
        expect(response.body).to match(/Couldn't find Product/)
      end

      it "return the status code 404" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT /product/:id" do
    let(:valid_attributes) { { id: product_id, name: 'Española' } }
    before { put :update, params: valid_attributes }

    context "when the record exist" do
      it "update the record" do
        expect(response.body).to be_empty
      end

      it "return status code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe "DELETE /product/:id" do
    before { delete :destroy, params: {id: product_id} }

    it "return code 204" do
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "PUT /products/:id/store/:store_id" do
    let(:valid_attributes) { { id: product_id, store_id: stores.sample.id } }
    before { put :add_store, params: valid_attributes }

    context "when the request is valid" do
      
      it "return code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the request is not valid" do
      let(:invalid_attributes) { { id: 1000000, store_id: 1000000000 } }
      before { put :add_store, params: invalid_attributes }

      it "returns status code 422" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /products/:id/store/:store_id" do
    let(:valid_attributes) { { id: product_id, store_id: stores.sample.id } }
    before { delete :delete_store, params: valid_attributes }

    context "when the request is valid" do
      
      it "return code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the request is not valid" do
      let(:invalid_attributes) { { id: 1000000, store_id: 1000000000 } }
      before { delete :delete_store, params: invalid_attributes }

      it "returns status code 422" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
