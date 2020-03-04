include Response

class Api::V1::ProductsController < ApplicationController
  before_action :set_api_v1_product, only: [:show, :update, :destroy]

  # GET /api/v1/products
  # GET /api/v1/products.json
  def index
    @api_v1_products = Product.all
  end

  # GET /api/v1/products/1
  # GET /api/v1/products/1.json
  def show
  end

  # POST /api/v1/products
  # POST /api/v1/products.json
  def create
    @api_v1_product = Product.new(api_v1_product_params)

    if @api_v1_product.save
      render :show, status: :created, location: @api_v1_product
    else
      render json: @api_v1_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/products/1
  # PATCH/PUT /api/v1/products/1.json
  def update
    if @api_v1_product.update(api_v1_product_params)
      render :show, status: :ok, location: @api_v1_product
    else
      render json: @api_v1_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/1
  # DELETE /api/v1/products/1.json
  def destroy
    @api_v1_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_product
      @api_v1_product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_product_params
      params.fetch(:api_v1_product, {})
    end
end
