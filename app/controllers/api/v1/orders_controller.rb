class Api::V1::OrdersController < ApplicationController
  before_action :set_api_v1_order, only: [:show, :update, :destroy]

  # GET /api/v1/orders
  # GET /api/v1/orders.json
  def index
    @api_v1_orders = Api::V1::Order.all
  end

  # GET /api/v1/orders/1
  # GET /api/v1/orders/1.json
  def show
  end

  # POST /api/v1/orders
  # POST /api/v1/orders.json
  def create
    @api_v1_order = Api::V1::Order.new(api_v1_order_params)

    if @api_v1_order.save
      render :show, status: :created, location: @api_v1_order
    else
      render json: @api_v1_order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/orders/1
  # PATCH/PUT /api/v1/orders/1.json
  def update
    if @api_v1_order.update(api_v1_order_params)
      render :show, status: :ok, location: @api_v1_order
    else
      render json: @api_v1_order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/orders/1
  # DELETE /api/v1/orders/1.json
  def destroy
    @api_v1_order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_order
      @api_v1_order = Api::V1::Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_order_params
      params.fetch(:api_v1_order, {})
    end
end
