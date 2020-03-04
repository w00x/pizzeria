require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
  let!(:stores) { create_list(:store, 10) }
  let(:store_id) { stores.first.id }
  let(:products) { create_list(:product, 5) }

  describe "GET /store" do
    before { get :index }

    it "return stores list" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "return status code 200" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /store" do
    let(:valid_attributes) { { name: 'Costanera center', address: 'direccion 333', email: 'blas@soto.com', phone: '987665436' } }

    context "when the request is valid" do
      before { post :create, params: valid_attributes }

      it "create a todo" do
        expect(json['name']).to eq('Costanera center')
        expect(json['address']).to eq('direccion 333')
        expect(json['email']).to eq('blas@soto.com')
        expect(json['phone']).to eq('987665436')
      end

      it "return 201 code" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when the request is not valid" do
      before { post :create, params: { name: nil, address: nil, email: nil, phone: nil } }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "return a failure message" do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe "GET /store/:id" do
    before { get :show, params: {id: store_id} }

    context "when the record exist" do
      it "return the store" do
        expect(json).not_to be_empty
      end

      it "return the status code 200" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the record does not exist" do
      let(:store_id) { 100000 }

      it "return a not found message" do
        expect(response.body).to match(/Couldn't find Store/)
      end

      it "return the status code 404" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT /store/:id" do
    let(:valid_attributes) { { id: store_id, name: 'Los Leones' } }
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

  describe "DELETE /store/:id" do
    before { delete :destroy, params: {id: store_id} }

    it "return code 204" do
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "POST /stores/:id/add_products" do
    let(:valid_attributes) { { id: store_id, product_ids: products.map(&:id) } }
    before { post :add_products, params: valid_attributes }

    context "when the request is valid" do
      before { post :create, params: valid_attributes }

      it "create a todo" do
        expect(json['name']).to eq('Costanera center')
        expect(json['address']).to eq('direccion 333')
        expect(json['email']).to eq('blas@soto.com')
        expect(json['phone']).to eq('987665436')
      end

      it "return 201 code" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when the request is not valid" do
      before { post :create, params: { name: nil, address: nil, email: nil, phone: nil } }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "return a failure message" do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end
end
