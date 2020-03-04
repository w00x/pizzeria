include Response

class Api::V1::ProductsController < ApplicationController
  before_action :set_api_v1_product, only: [:show, :update, :destroy, :add_stores, :delete_stores]

  # GET /api/v1/products
  # GET /api/v1/products.json
  def index
    @api_v1_products = Product.all
    json_response(@api_v1_products)
  end

  # GET /api/v1/products/1
  # GET /api/v1/products/1.json
  def show
    json_response(@api_v1_product)
  end

  # POST /api/v1/products
  # POST /api/v1/products.json
  def create
    ActiveRecord::Base.transaction do
      begin
        @api_v1_product = Product.create!(api_v1_product_params)

        json_response @api_v1_product, :created
      rescue => ex
        json_response({error: ex.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
    end
  end

  # PATCH/PUT /api/v1/products/1
  # PATCH/PUT /api/v1/products/1.json
  def update
    begin
      @api_v1_product.update!(api_v1_product_params)
      head :no_content
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  # DELETE /api/v1/products/1
  # DELETE /api/v1/products/1.json
  def destroy
    begin
      @api_v1_product.destroy!
      head :no_content
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  def add_stores
    ActiveRecord::Base.transaction do
      begin
        @api_v1_product.stores << Store.find(params[:store_id])
        @api_v1_product.reload

        json_response @api_v1_product, :ok
      rescue => ex
        json_response({error: ex.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
    end
  end

  def delete_stores
    ActiveRecord::Base.transaction do
      begin
        @api_v1_product.stores.delete(Store.find(params[:store_id]))
        @api_v1_product.reload

        json_response @api_v1_product, :ok
      rescue => ex
        json_response({error: ex.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_product
      begin
        @api_v1_product = Product.find(params[:id])
      rescue => ex
        json_response({error: ex.message}, :not_found)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_product_params
      params.permit(:name, :sku, :type, :price, :order_id)
    end
end
